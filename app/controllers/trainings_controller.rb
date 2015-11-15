class TrainingsController < ApplicationController
  def index
  	param! :climber_id,           Integer, required: true
  	
  	@trainings = Training.all.order(date: :desc)
    respond_to do |format|
      format.html
    end
  end

  def new
  	@trainings = Training.new
  end

end