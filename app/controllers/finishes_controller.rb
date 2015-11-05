class FinishesController < ApplicationController
  def index
  	@finishes = Finish.all
    respond_to do |format|
      format.html
    end
  end
end