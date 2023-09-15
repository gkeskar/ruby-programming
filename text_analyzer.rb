#!/usr/bin/env ruby
require 'optparse'

options = {}
optparse = OptionParser.new do|opts|
  opts.on('-f', '--file FILE', 'input file') do |f|
    options[:file] = f
  end
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end
optparse.parse!
p "Options:", options

if options[:file].nil?
  puts optparse
  exit 1
end

stopwords = %w{the a by on for of are with just but and to the my I}
lines = File.readlines(options[:file])
line_count = lines.size
text = lines.join
char_count = text.length
char_count_without_spaces = text.gsub(/\s+/,'').length

word_count = text.scan(/\w+/).length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length

# Make a list of words in the text that aren't stop words,
# count them, and work out the percentage of non-stop words
# against all words
all_words = text.scan(/\w+/)
good_words = all_words.reject{ |word| stopwords.include?(word) }
good_percentage = ( (good_words.length.to_f / all_words.length.to_f) * 100 ).to_i

# Summarize the text by cherry picking some choice
sentences = text.gsub(/\s+/, ' ').strip.split(/\.|\?|!/)
sentences_sorted = sentences.sort_by { |sentence| sentence.length }
one_third = sentences_sorted.length / 3
ideal_sentences = sentences_sorted.slice(one_third, one_third + 1)
ideal_sentences = ideal_sentences.select { |sentence| sentence =~ /is|are/ }

# Give analysis back to user
puts "#{line_count} lines"
puts "#{char_count} characters"
puts "#{char_count_without_spaces} characters (excluding spaces)"
puts "#{word_count} words"
puts "#{sentence_count} sentences"
puts "#{paragraph_count} paragraphs"
puts "#{word_count / sentence_count} words per sentence (average)"
puts "#{sentence_count / paragraph_count} sentences per paragraph (average)"
puts "#{good_percentage}% of words are non-fluff words"
puts "Summary:\n\n" + ideal_sentences.join(". ")
puts "-- End of analysis"



