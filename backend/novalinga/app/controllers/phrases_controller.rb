class PhrasesController < ApplicationController
  # GET /phrases
  def index
    @phrases = Phrase.all
    render json: @phrases, status: :ok
  end

  # GET /phrases/:id
  def show
    @phrase = Phrase.find(params[:id]) 
    render json: @phrase, status: :ok
  end

  #POST /phrases
  def create 
    @phrase = Phrase.new(create_params)
    @phrase.save
    render json: @phrase, status: :created
  end

  # PUT /phrases/:id
  def update
    @phrase = Phrase.find(params[:id])
    @phrase.update!(update_params)
    render json: @phrase, status: :ok
  end

  #DELETE /phrases/:id
  def destroy
    @phrase = Phrase.find(params[:id])
    @phrase.destroy
    render json: @phrase, status: :ok
  end

  private
  def create_params
    params.require(:phrase).permit(:input_language, :output_language, :phonetic, :audio_url, :lesson_id)
  end

  def update_params
    params.require(:phrase).permit(:input_language, :output_language, :phonetic, :audio_url)
  end
end
