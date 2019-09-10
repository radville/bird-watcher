class CreateBirdSightings < ActiveRecord::Migration
  def change
    create_table :bird_sightings do |t|
      t.string :common_name
      t.string :scientific_name
      t.datetime :datetime
      t.string :location
      t.string :description
      t.string :order
      t.string :family
      t.string :url
      t.string :img_src
      t.string :credit
      t.string :license_url
      t.integer :user_id
      
    end
  end
end