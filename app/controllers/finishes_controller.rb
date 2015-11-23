class FinishesController < ApplicationController

	before_action :authenticate_climber!, :except => [:index]

  def index
  	param! :training_id,           Integer, required: true

    authenticate_climber! unless climber_public? Training.find(params[:training_id]).climber_id
    @is_owner = belong_to_current_user? Training.find(params[:training_id]).climber_id

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

  def edit
    @finish = Finish.find(params[:id])
    params[:training_id] = @finish.training.id
  end

  def update
    @finish = Finish.find(params[:id])
    respond_to do |format|
      if @finish.update_attributes(finish_params)
        format.html { redirect_to finishes_path(training_id: @finish.training.id), notice: 'update success' }
      else
        format.html { redirect_to edit_finish_path(@finish), notice: 'update failed, please try again.' }
      end
    end
  end

  def destroy
    binding.pry
    training_id = Finish.find(params[:id]).training.id
    Finish.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'delete success' }
    end
  end

  private 

  def finish_params
    params.require(:finish).permit(:catagory, :difficulty, :value,:training_id)
  end

end