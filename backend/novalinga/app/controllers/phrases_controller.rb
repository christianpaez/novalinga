class PhrasesController < ApplicationController
  # GET phrases/
  def index
    @phrases = Phrase.all
    render json: @phrases, status: :ok
  end

  # GET phrases/:id
  def show
    @phrase = Phrase.find(params[:id]) 
    render json: @phrase, status: :ok
  end
end
