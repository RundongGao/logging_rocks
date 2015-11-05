class TrainingsController < ApplicationController
  def index
  	@trainings = Training.all
    respond_to do |format|
      format.html
    end
  end
end