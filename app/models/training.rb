class Training < ActiveRecord::Base
  belongs_to :climber
  has_many :finishes, dependent: :destroy

  def self.climber_id trainging_id
  	find(trainging_id).climber_id
  end
end