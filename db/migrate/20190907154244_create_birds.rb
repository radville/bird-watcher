class CreateBirds < ActiveRecord::Migration
  def change
    create_table :birds do |t|
      t.string :scientific_name
      t.string :common_name
      t.string :order
      t.string :family
      t.string :url
      t.string :img_src
      t.string :credit
      t.string :license_url
    end
  end
end