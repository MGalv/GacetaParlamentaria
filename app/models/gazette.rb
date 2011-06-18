class Gazette < ActiveRecord::Base
  has_many :pronouncements
  validates_presence_of :serial
  validates_uniqueness_of :serial
end
