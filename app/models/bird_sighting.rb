# require_relative "./slugifier.rb"

class BirdSighting < ActiveRecord::Base
    # extend Slugifier::ClassMethods
    # include Slugifier::InstanceMethods

    belongs_to :user

    def slug
        self.common_name.downcase.gsub(" ","-")
    end

    def self.find_by_slug(slug)
        self.all.find{|sighting| sighting.slug == slug}
    end

end