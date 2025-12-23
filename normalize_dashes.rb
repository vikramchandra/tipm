#!/usr/bin/env ruby
# Replaces all types of dashes with a standard hyphen-minus (-)

if ARGV.empty?
  puts "Usage: ruby normalize_dashes.rb <file1> [file2] [file3] ..."
  exit 1
end

# All dash-like characters to replace:
# - U+2010 Hyphen
# - U+2011 Non-breaking hyphen
# - U+2012 Figure dash
# - U+2013 En dash
# - U+2014 Em dash
# - U+2015 Horizontal bar
# - U+2212 Minus sign
# - U+FE58 Small em dash
# - U+FE63 Small hyphen-minus
# - U+FF0D Fullwidth hyphen-minus

DASH_PATTERN = /[\u2010\u2011\u2012\u2013\u2014\u2015\u2212\uFE58\uFE63\uFF0D]/

total_count = 0

ARGV.each do |file_path|
  unless File.exist?(file_path)
    puts "Error: File '#{file_path}' not found, skipping"
    next
  end

  content = File.read(file_path)
  count = content.scan(DASH_PATTERN).length

  if count > 0
    normalized = content.gsub(DASH_PATTERN, ' - ')
    File.write(file_path, normalized)
    puts "Replaced #{count} dash(es) in #{file_path}"
    total_count += count
  else
    puts "No dashes to replace in #{file_path}"
  end
end

puts "Total: #{total_count} dash(es) replaced across #{ARGV.length} file(s)"
