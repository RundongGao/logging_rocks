class FinishesController < ApplicationController

	before_action :authenticate_climber!, :except => [:index]

  def index
  	param! :training_id,           Integer, required: true

    authenticate_climber! unless climber_public? Training.climber_id(params[:training_id])

    @is_owner = belong_to_current_user? Training.climber_id(params[:training_id])
    @training = Training.find(params["training_id"])
  	@finishes = @training.finishes.decorate

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

    @finish = Finish.new(create_finish_params)

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
  end

  def update
    @finish = Finish.find(params[:id])
    respond_to do |format|
      if @finish.update_attributes(update_finish_params)
        format.html { redirect_to finishes_path(training_id: @finish.training_id), notice: 'update success' }
      else
        format.html { redirect_to :back, notice: 'update failed, please try again.' }
      end
    end
  end

  def destroy
    training_id = Finish.find(params[:id]).training_id
    Finish.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'delete success' }
    end
  end

  private 

  def update_finish_params
    params.require(:finish).permit(:catagory, :difficulty, :value)
  end

  def create_finish_params
    params.require(:finish).permit(:catagory, :difficulty, :value,:training_id)
  end

end