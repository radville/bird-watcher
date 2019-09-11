require_relative "./slugifier.rb"

class BirdSighting < ActiveRecord::Base
    extend Slugifier::ClassMethods
    include Slugifier::InstanceMethods

    belongs_to :user
end