class CreateBirdSightings < ActiveRecord::Migration
  def change
    create_table :bird_sightings do |t|
      t.string :common_name
      t.string :scientific_name
      t.date :date
      t.time :time
      t.string :location
      t.string :description
      t.integer :user_id
    end
  end
end