# require_relative "./slugifier.rb"

class BirdSighting < ActiveRecord::Base
    # extend Slugifier::ClassMethods
    # include Slugifier::InstanceMethods

    belongs_to :user

    def slug
        self.common_name.downcase.gsub(" ","-").gsub("'", "%27") + self.id.to_s
    end

    # def self.find_by_slug(slug)
    #     self.all.find{|sighting| sighting.slug == slug }
    # end

    def self.find_by_slug_user(slug, user_id)
        self.all.find{|sighting| sighting.slug == slug.gsub("'", "%27") && sighting.user_id == user_id}
    end

end