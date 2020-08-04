class PhrasesController < ApplicationController
  include ApplicationHelper
  include PhrasesHelper
  before_action :require_login, only: [:index, :show], :unless => :html_request?
  before_action :set_lesson_and_course, only: [:index, :new, :create, :show, :edit, :update, :destroy] 
  before_action :set_phrase, only: [:show, :edit, :update, :destroy]
  
  # GET courses/:course_id/lessons/:lesson_id/phrases
  def index
    @phrases = Phrase.where(lesson_id: @lesson.id)
    if @phrases
      respond_to do |format|
        format.json  { render json: {message: "Phrases retrieved", data: @phrases}, status: :ok }
        format.html  { render :index }
      end
    else
      respond_to do |format|
          format.json { render json: @phrases.errors, status: :unprocessable_entity }
          format.html  { redirect_to course_lessons_path(@course, @lesson) }
      end
    end
  end

  # GET courses/:course_id/lessons/:lesson_id/phrases/:id
  def show
    respond_to do |format|
        format.json {     render json: {message: "Phrase retrieved with id: #{params[:id]}", data: @phrase}, status: :ok }
        format.html { render :show} 
    end
  end

  def new
    @phrase = Phrase.new
    
  end

  # #POST /courses/:id/lessons/:id/phrases
  def create 
    @phrase = Phrase.new(phrase_params)
    respond_to do |format|
      if @phrase.save
        format.html { redirect_to course_lesson_phrase_path(@course, @lesson, @phrase), notice: 'Phrase was successfully created.' }
        format.json { render json: @phrase, status: :created }
      else
        format.html { render :new }
        format.json { render json: @phrase.errors, status: :unprocessable_entity }
      end
    end
end

def edit
  
end

def update
  respond_to do |format|
      if @phrase.update(phrase_params)
          format.html { redirect_to course_lesson_phrase_path(@course, @lesson, @phrase), flash: {info: 'Phrase was successfully updated.'} }
          format.json { render json: {message: "Lesson Updated with id: #{@phrase[:id]}", data: @phrase}, status: :ok }
      else
          format.html { render :edit }
          format.json { render json: @phrase.errors, status: :unprocessable_entity }
      end
  end
end

  # #POST /phrases
  # def create 
  #   @phrase = Phrase.new(create_params)
  #   @phrase.save
  #   render json: @phrase, status: :created
  # end

  # # PUT /phrases/:id
  # def update
  #   @phrase = Phrase.find(params[:id])
  #   @phrase.update!(update_params)
  #   render json: @phrase, status: :ok
  # end

  # #DELETE /phrases/:id
  # def destroy
  #   @phrase = Phrase.find(params[:id])
  #   @phrase.destroy
  #   render json: @phrase, status: :ok
  # end

  def destroy
    respond_to do |format|
        if @phrase.destroy
            format.html { redirect_to course_lesson_phrases_path(@course, @lesson), flash: {info: 'Phrase was successfully deleted.'} }
            format.json { render json: {message: "Phrase Deleted with id: #{@phrase[:id]}"}, status: :ok }
        else
            format.html { render :index }
            format.json { render json: @phrase.errors, status: :unprocessable_entity }
        end
    end
    
end

  private
  def phrase_params
    params.require(:phrase).permit(:input_language, :output_language, :phonetic, :audio_url, :lesson_id)
  end
end
