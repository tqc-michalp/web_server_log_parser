# frozen_string_literal: true

# Open a file and put every line to an array
class FileReader
  def initialize(path)
    @path = File.expand_path(path)
  end

  def read
    File.open(@path, 'r').readlines
  rescue Errno::ENOENT => e
    warn "Error: #{e}"
    exit(-1)
  end
end
