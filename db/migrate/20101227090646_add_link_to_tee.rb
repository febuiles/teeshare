class AddLinkToTee < ActiveRecord::Migration
  def self.up
    add_column :tees, :link, :string
  end

  def self.down
    remove_column :tees, :link
  end
end
