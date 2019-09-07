class User < ActiveRecord::Base
    has_secure_password
    has_many :bird_sightings
end