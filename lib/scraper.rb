require_relative 'output'

require 'nokogiri'
require 'httparty'

class Scraper

   attr_accessor :input, :index, :node

   def initialize(input, index)
      @input   = input
      @index   = index
      @node    = Nokogiri::HTML(HTTParty.get(index[:url]).body)
   end

   def scraper_call
      scraper_status
      scraper_current_value
      scraper_change_from_open
      scraper_year_range
      Output.new(index).call
   end

   def scraper_status
      if index[:status].call(node) == "Closed"
         index[:status] = "Closed" #.colorize(:red)
      else
         index[:status] = "Open"
      end
   end

   def scraper_current_value
      index[:current_value] = index[:current_value].call(node)
   end

   def scraper_change_from_open
      if index[:change_from_open].call(node).include? "-"
         index[:change_from_open] = index[:change_from_open].call(node) #.colorize(:red)
      else
         index[:change_from_open] = index[:change_from_open].call(node)   
      end
   end

   def scraper_year_range
      index[:year_range] = index[:year_range].call(node)
   end

end