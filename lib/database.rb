require_relative 'scraper'

class Database

   attr_accessor :input, :index, :indexes_hash

   def initialize(input)
      @input = input
      @index = index
      @@indexes_hash = indexes_hash
      # @@indexes_hash = nil
   end

   def call
      db_to_index
   end

   # css = css.to_sym

   @nokogiri_selectors = {
      :status           => ->(node) { node.css('div.instrument-metadata_time__3kNQ2').search('span:nth-child(3)').text },
      :current_value    => ->(node) { node.css('div.instrument-price_instrument-price__3uw25').css('span.text-2xl').text },
      :change_from_open => ->(node) { node.css('div.instrument-price_instrument-price__3uw25').css('span.instrument-price_change-value__jkuml').text },
      :year_range       => ->(node) { node.css('div.instrumentOverview_overview-section__2hN4A').search('dl:nth-child(1)').search('div:nth-child(6)').css('dd').text }
   }

   @@indexes_hash = {
      "dax" => {
         full_name:        "Deutscher Aktienindex",
         stock_exchange:   "Frankfurt Stock Exchange",
         primary_currency: "Euro",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/germany-30"
      },
      "fchi" => {
         full_name:        "Cotation Assistée en Continu",
         stock_exchange:   "Euronext Paris",
         primary_currency: "Euro",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/france-40"
      },
      "ftse" => {
         full_name:        "Financial Times Stock Exchange 100",
         stock_exchange:   "London Stock Exchange",
         primary_currency: "Pounds",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/uk-100"
      },
      "dji" => {
         full_name:        "Dow Jones Industrial Average",
         stock_exchange:   "NYSE, NASDAQ",
         primary_currency: "US Dollar",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/us-30"
      },
      "ixic" => {
         full_name:        "Nasdaq Composite",
         stock_exchange:   "NASDAQ",
         primary_currency: "US Dollar",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/nasdaq-composite"
      },
      "spx" => {
         full_name:        "Standard and Poor's 500",
         stock_exchange:   "NYSE, NASDAQ, Cboe BZX Exchange",
         primary_currency: "US Dollar",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/us-spx-500"
      },
      "hsi" => {
         full_name:        "Hang Seng Index",
         stock_exchange:   "Hong Kong Stock Exchange",
         primary_currency: "Hong Kong Dollar",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/hang-sen-40"
      },
      "ks11" => {
         full_name:        "Korea Composite Stock Price Index",
         stock_exchange:   "Main Board (KOSPI Market)",
         primary_currency: "South Korean Won",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/kospi"
      },
      "n225" => {
         full_name:        "Nikkei 225",
         stock_exchange:   "Tokyo Stock Exchange",
         primary_currency: "Japanese Yen",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/japan-ni225"
      },
      "ssec" => {
         full_name:        "Shanghai Composit Index",
         stock_exchange:   "Shanghai Stock Exchange",
         primary_currency: "Chinese Yuan",
         status:           @nokogiri_selectors[:status],
         current_value:    @nokogiri_selectors[:current_value],   
         change_from_open: @nokogiri_selectors[:change_from_open],
         year_range:       @nokogiri_selectors[:year_range],
         # hidden
         url:              "https://www.investing.com/indices/shanghai-composite"
      }
   }

   def db_to_index
      binding.pry
      @@indexes_hash = nil
      @@indexes_hash[@input]
      @index = @@indexes_hash[@input]
      Scraper.new(index).scraper_call
   end

end
