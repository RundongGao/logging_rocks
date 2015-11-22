class FinishesController < ApplicationController

	before_action :authenticate_climber!, :except => [:index]

  def index
  	param! :training_id,           Integer, required: true

  	@finishes = Finish.where(training_id: params["training_id"])
    respond_to do |format|
      format.html
    end
  end

   def create
    param! :finish, Hash do |t|
      t.param! :catagory , String, required: true
      t.param! :difficulty , String, required: true
      t.param! :value , String, required: true
      t.param! :training_id, Integer, required: true
    end

    @finish = Finish.new(finish_params)

    respond_to do |format|
      if @finish.save
        format.html { redirect_to :back }
      else
        format.html { redirect_to :back, notice: 'finish was not successfully created.'  }
      end
    end
  end

  def new
  	@finish = Finish.new
  end

  private 

  def finish_params
    params.require(:finish).permit(:catagory, :difficulty, :value,:training_id)
  end

end