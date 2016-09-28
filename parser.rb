require 'pry'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

quit = 0
while quit != "q"
  puts "Gimme a website:"
  page_url = gets.chomp
  if page_url.include?("www.")
  else
    page_url = "www.#{page_url}"
  end

  if page_url.include?("http://")
  else
    page_url = "http://#{page_url}"
  end
#begin and rescue for errors
  page = Nokogiri::HTML(open(page_url))
  links = page.css("a")
  puts "There are #{links.length} links on that page."
  puts "\nPress Q to Quit, any other key to continue..."
  quit = gets.chomp
end
