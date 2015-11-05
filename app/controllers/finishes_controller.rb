class FinishesController < ApplicationController
  def index
  	@finishes = Finish.all
  	require 'pry'
    respond_to do |format|
      format.html
    end
  end
end