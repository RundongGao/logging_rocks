class Finish < ActiveRecord::Base
  belongs_to :training

  def climber_id
    training.climber.id
  end
end