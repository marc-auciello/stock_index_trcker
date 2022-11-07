require_relative 'input'

class Output

   attr_accessor :index

   def initialize(index)
      @index = index
   end

   def call
      output
      know_more
      Input.new.display_index_options
   end

   def output
      puts " "
      puts "-----------------------------------------------------"
      puts "Full Name:          #{index[:full_name]}"
      puts "Stock Exchange:     #{index[:stock_exchange]}"
      puts "Primary Currency:   #{index[:primary_currency]}"
      puts "Status:             #{index[:status]}"
      puts "Current Value:      #{index[:current_value]} points"
      puts "Change From Open:   #{index[:change_from_open]} points"
      puts "52 Week High / Low: #{index[:year_range]} points"
      puts "-----------------------------------------------------"
      puts " "
   end

   def know_more
      puts " "
      puts "Would you like to search a different index?"
   end


end
