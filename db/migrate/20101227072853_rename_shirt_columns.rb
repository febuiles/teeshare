class RenameShirtColumns < ActiveRecord::Migration
  def self.up
    change_table :tees do |t|
      t.rename :shirt_name, :name
      t.rename :shirt_image_url, :image_url
    end
  end

  def self.down
    change_table :tees do |t|
      t.rename :name, :shirt_name
      t.rename :image_url, :shirt_image_url
    end
  end
end
