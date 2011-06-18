class Gazette < ActiveRecord::Base
  has_many :pronouncements
  validates_presence_of :serial
  validates_uniqueness_of :serial

  acts_as_api

  api_accessible :gazette do |template|
    template.add :serial, :as => :numero_de_gaceta
    template.add :published_at, :as => :fecha_de_publicacion
    template.add lambda{|gazette| gazette.pronouncements.count }, :as => :dictamenes
  end

end
