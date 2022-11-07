require_relative 'database'
require 'colorize'

class Input

   attr_accessor :input
   
   def initialize
      @input = input
   end


   def call
      greeting
      display_index_options
      get_input
   end

   def greeting
      puts "Welcome to the Index Tracker!"
      puts " "
      puts "What index you would like to know more about?"
   end

   def display_index_options
      puts " "
      puts "Please select the index from the list below by typing the index name."
      puts " "
      puts "| Region          Index Name".colorize(:white)
      puts "| Europe:         DAX, FCHI, FTSE"
      puts "| North America:  DJI, IXIC, SPX"
      puts "| Asia:           HSI, KS11, N225, SSEC"
      puts " "
      puts "Or type exit to #{"exit".colorize(:white)} the program"

   end

   def get_input
      indexes = ["dax", "fchi", "ftse", "dji", "ixic", "spx", "hsi", "ks11", "n225", "ssec"]
      input = nil
      while input != "exit"
         if indexes.include? input
            Database.new(input).call
         else
            if input != nil
               puts " "
               puts "#{input.colorize(:red)} is not an index from the list."
               display_index_options
            end
         end
         input = gets.chomp.downcase
      end
   end 

end

