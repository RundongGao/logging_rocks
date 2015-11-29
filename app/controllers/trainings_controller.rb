class TrainingsController < ApplicationController
  before_action :authenticate_climber!, :except => [:index]
   
  # request a climber_id 
  def index
  	param! :climber_id,           Integer, required: true

    authenticate_climber! unless climber_public? params[:climber_id]
    @is_owner = belong_to_current_user? params[:climber_id]

    climber = Climber.find(params[:climber_id])
  	@trainings = climber.trainings.order(date: :desc).decorate

    respond_to do |format|
      format.html
    end
  end

  def new
  	@training = Training.new
  end

  def edit
    @training = Training.find(params[:id])
  end

  def create
    param! :training, Hash do |t|
      t.param! :date, Date, required: true
    end

    @training = Training.new(training_params.merge(climber_id: current_climber.id))

    respond_to do |format|
      if @training.save
        format.html { redirect_to new_finish_path(training_id: @training.id), notice: 'climbing record was successfully created.'}
      else
        format.html { redirect_to :back, notice: 'climbing record was not successfully created.' }
      end
    end
  end

  def update
    @training = Training.find(params[:id])
    respond_to do |format|
      if @training.update_attributes(training_params)
        format.html { redirect_to finishes_path(training_id: @training.id), notice: 'climbing record update success' }
      else
        format.html { redirect_to :back, notice: 'limbing record update failed, please try again.' }
      end
    end
  end

  def destroy
    Training.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'limbing record delete success' }
    end
  end

  private 

  def training_params
    params.require(:training).permit(:date)
  end
end