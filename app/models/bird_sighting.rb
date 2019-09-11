class BirdSighting < ActiveRecord::Base
    belongs_to :user

    def slug
        common_name.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        self.all.find{|sighting| sighting.slug == slug}
    end

end