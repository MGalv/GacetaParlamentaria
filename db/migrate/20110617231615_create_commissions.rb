class CreateCommissions < ActiveRecord::Migration
  def self.up
    create_table :commissions do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :commissions
  end
end
