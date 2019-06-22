# frozen_string_literal: true

# Processing log
class Parser
  # Delegated responsibility in order to get encapsulate data
  class Tokenizer < SimpleDelegator
    attr_reader :url, :ipv4
    def initialize(row)
      super
      @url = extract_url(row)
      @ipv4 = extract_ipv4(row)
    end

    private

    def extract_url(row)
      %r{[/][a-z_]+[/]?[\d]?}.match(row).to_s
    end

    def extract_ipv4(row)
      /\d{3}.+/.match(row).to_s
    end
  end

  def initialize(data)
    @extracted = extracting(data)
  end

  def most_visited
    processing { |k, v| [k, v.length] }
  end

  def most_uniq_visits
    processing { |k, v| [k, v.group_by(&:ipv4).length] }
  end

  private

  def extracting(values)
    values.map { |item| Tokenizer.new(item) }
  end

  def grouping
    @grouping ||= @extracted.group_by(&:url)
  end

  def processing
    Hash[
      grouping
      .map { |k, v| yield(k, v) }
      .sort_by { |_k, v| v * -1 }
    ]
  end
end
