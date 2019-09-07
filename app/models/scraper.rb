class Scraper 
    def scrape_birds
        doc = Nokogiri::HTML(open("https://wildlifenorthamerica.com/A-Z/Bird/family.html"))
    end

    def self.scrape_bird_image(bird_url)
        doc = Nokogiri::HTML(open(bird_url))
        bird = Bird.find_by_url(bird_url)
        bird.img_src = doc.css("img").attribute("src").value
        bird.credit = doc.css(".smalltext").text[0..-21]
        bird.license_url = doc.css(".smalltext").children[1]["href"]
    end

end





