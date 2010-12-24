class AddShirtIdToTee < ActiveRecord::Migration
  def self.up
    add_column :tees, :shirt_id, :integer
  end

  def self.down
    remove_column :tees, :shirt_id
  end
end
