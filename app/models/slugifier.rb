module Slugifier
    module InstanceMethods
        def slug
            common_name.downcase.gsub(" ","-")
        end
    end

    module ClassMethods
        def find_by_slug(slug)
            self.all.find{|sighting| sighting.slug == slug}
        end
    end
end