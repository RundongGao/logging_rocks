class FinishesController < ApplicationController
  def index
  	param! :training_id,           Integer, required: true

  	@finishes = Finish.where(training_id: params["training_id"])
    respond_to do |format|
      format.html
    end
  end
end