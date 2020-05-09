class PhrasesController < ApplicationController
  def index
    @phrases = Phrase.all
    render json: @phrases, status: :ok
  end
end
