class User < ActiveRecord::Base
    has_secure_password

    validates :first_name, :email, presence: true
    validates :email, uniqueness: true

    has_many :bird_sightings
end