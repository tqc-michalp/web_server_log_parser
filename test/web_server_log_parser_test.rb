# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/web_server_log_parser'

class WebServerLogParserTest < Minitest::Test
  def setup
    @file = File.open('./webserver.log', 'r').readlines
  end

  def test_assert_hash_to_result_most_visited
    assert_instance_of Hash, Parser.new(@file).most_visited
  end

  def test_refute_integer_to_most_visited
    refute_instance_of Integer, Parser.new(@file).most_visited
  end

  def test_assert_hash_to_result_most_uniq_visits
    assert_instance_of Hash, Parser.new(@file).most_uniq_visits
  end

  def test_refute_string_to_most_uniq_visits
    refute_instance_of String, Parser.new(@file).most_uniq_visits
  end

  def test_refute_empty_to_most_visited
    refute_empty Parser.new(@file).most_visited
  end

  def test_refute_empty_to_most_uniq_visits
    refute_empty Parser.new(@file).most_uniq_visits
  end

  def test_assert_match_keys_to_result_most_visited
    Parser.new(@file).most_visited.keys.each do |key|
      assert_match %r{[/][a-z_]+[/]?[\d]?}, key
    end
  end

  def test_assert_match_keys_to_result_most_uniq_visits
    Parser.new(@file).most_uniq_visits.keys.each do |key|
      assert_match %r{[/][a-z_]+[/]?[\d]?}, key
    end
  end

  def test_sorted_values_to_result_most_visited
    assert_equal [90, 89, 82, 81, 80, 78], Parser.new(@file)
                                                 .most_visited.values
  end

  def test_sorted_values_to_result_most_uniq_visits
    assert_equal [23, 23, 23, 23, 22, 21], Parser.new(@file)
                                                 .most_uniq_visits.values
  end
end
