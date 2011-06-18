class CreateSteps < ActiveRecord::Migration
  def self.up
    create_table :steps do |t|
      t.string :state
      t.string :voted_where
      t.datetime :voted_at
      t.references :pronouncement

      t.timestamps
    end
  end

  def self.down
    drop_table :steps
  end
end
