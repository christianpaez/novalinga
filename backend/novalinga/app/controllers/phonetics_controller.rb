class PhoneticsController < ApplicationController
  def index
    @phonetics = Phonetic.all
    render json: @phonetics, status: :ok
  end

  def show
    @phonetic = Phonetic.find(params[:id])
    render json: @phonetic, data: :ok
  end
end
