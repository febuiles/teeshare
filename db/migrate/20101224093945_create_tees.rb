class CreateTees < ActiveRecord::Migration
  def self.up
    create_table :tees do |t|
      t.string :who
      t.integer :id
      t.string :shirt_name
      t.string :shirt_image_url

      t.timestamps
    end
  end

  def self.down
    drop_table :tees
  end
end
