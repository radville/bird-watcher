class Scraper 
    def self.scrape_birds
        doc = Nokogiri::HTML(open("https://wildlifenorthamerica.com/A-Z/Bird/family.html"))
    end
end





