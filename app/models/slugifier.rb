module Slugifier
    module InstanceMethods
        def slug
            self.downcase.gsub(" ","-")
        end

        def unslug
            self.gsub("-"," ")
        end
    end

    module ClassMethods
        def find_by_slug(slug)
            self.all.find{|object| object.slug == slug}
        end
    end
end