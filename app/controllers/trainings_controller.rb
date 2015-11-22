class TrainingsController < ApplicationController
  before_action :authenticate_climber!, :except => [:index]

  # todo
  # next step is differentiate two indexes
  # one is for index climbers own trainings
  # with authentication
  # another one is to index public records
  # no need for authentication but verification that those records are indeed public

  def index
  	param! :climber_id,           Integer, required: true
  	
  	@trainings = Training.all.order(date: :desc)
    respond_to do |format|
      format.html
    end
  end

  def new
  	@training = Training.new
  end

  def create
    param! :training, Hash do |t|
      t.param! :date, Date, required: true
    end

    @training = Training.new(training_params.merge(climber_id: current_climber.id))

    respond_to do |format|
      if @training.save
        format.html { redirect_to new_finish_path(training_id: @training.id), notice: 'training was successfully created.'}
      else
        format.html { redirect_to new_training_path, notice: 'training was not successfully created.' }
      end
    end
  end

  private 
  def training_params
    params.require(:training).permit(:date)
  end
end