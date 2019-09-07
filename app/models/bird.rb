class Bird < ActiveRecord::Base
    def self.create_from_scraper(doc)
        doc.css("table table tr").drop(1).each do |row|
            bird = Bird.create
            bird.order = row.css("td")[0].text
            bird.family = row.css("td")[1].text
            bird.scientific_name = row.css("td")[2].text
            bird.url = row.css("td")[2].children[0]["href"]
            bird.common_name = row.css("td")[3].text[1..-2]
            Scraper.scrape_bird_image(bird.url)
        end
    end

end