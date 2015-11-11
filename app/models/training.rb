class Training < ActiveRecord::Base
  belongs_to :climber
  has_many :finishes
end