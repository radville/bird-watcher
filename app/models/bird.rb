class Bird < ActiveRecord::Base
    def self.create_from_scraper(doc)
        doc.css("table table tr").drop(1).each do |row|
            bird = Bird.new(order: row.css("td")[0].text, family: row.css("td")[1].text, scientific_name: row.css("td")[2].text, common_name: row.css("td")[3].text[1..-2], url: row.css("td")[2].children[0]["href"])
            url_doc = Nokogiri::HTML(open(bird.url))
            bird.img_src = url_doc.css("img").attribute("src").value
            bird.credit = url_doc.css(".smalltext")[0].text
            bird.license_url = url_doc.css(".smalltext").children[1]["href"]
            bird.save
        end
    end
end