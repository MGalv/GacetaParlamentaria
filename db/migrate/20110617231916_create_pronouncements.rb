class CreatePronouncements < ActiveRecord::Migration
  def self.up
    create_table :pronouncements do |t|
      t.text :details
      t.references :gazette
      t.string :url_reference
      t.timestamps
    end
  end

  def self.down
    drop_table :pronouncements
  end
end
