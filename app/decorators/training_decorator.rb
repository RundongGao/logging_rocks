class TrainingDecorator < Draper::Decorator
  delegate_all
  def total
  	object.finishes.sum(:value)
  end

  def boundering_total
  	object.finishes.where(catagory: 'bouldering').sum(:value)
  end

  def top_rope_total
  	object.finishes.where(catagory: 'top_rope').sum(:value)
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
