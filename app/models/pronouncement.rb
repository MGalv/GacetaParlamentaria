class Pronouncement < ActiveRecord::Base
  belongs_to :gazette
  has_many :steps
  has_and_belongs_to_many :commissions
end
