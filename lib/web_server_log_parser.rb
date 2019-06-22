#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'web_server_log_parser/file_reader'
require_relative 'web_server_log_parser/parser'

# Starting the application and showing the result
if ARGV.empty?
  puts <<-HEREDOC
  You need provide a filename as an argument
  in format e.g. ./start.rb ../test/nginx.log
  HEREDOC
  return 0
end
outcome = Parser.new(FileReader.new(ARGV[0]).read)
puts 'List of most_visited websites:'
puts outcome.most_visited
puts 'List of most uniq visits:'
puts outcome.most_uniq_visits
