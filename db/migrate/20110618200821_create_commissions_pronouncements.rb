class CreateCommissionsPronouncements < ActiveRecord::Migration
  def self.up
    create_table :commissions_pronouncements, :id => false  do |t|
      t.references :pronouncement
      t.references :commission
    end
  end

  def self.down
    drop_table :commissions_pronouncements
  end
end
