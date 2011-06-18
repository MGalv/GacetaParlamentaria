class CreateGazettes < ActiveRecord::Migration
  def self.up
    create_table :gazettes do |t|
      t.string :serial
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :gazettes
  end
end
