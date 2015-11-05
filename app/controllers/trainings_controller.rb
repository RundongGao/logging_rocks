class TrainingsController < ApplicationController
  def index
  	@trainings = Training.all.order(date: :desc)
    respond_to do |format|
      format.html
    end
  end
end