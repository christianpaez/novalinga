class LessonsController < ApplicationController
    include ApplicationHelper
    include LessonsHelper
    before_action :require_login, only: [:index, :show], :unless => :html_request?
    before_action :authenticate_admin!, :if => :html_request?
    before_action :set_course, only: [:index, :show, :new, :edit, :update, :destroy]
    before_action :set_lesson, only: [:show, :edit, :update,:destroy]
    # GET /lessons
    def index
        @lessons = Lesson.where(course_id: @course[:id])
        if @lessons
            respond_to do |format|
              format.json { render json: @course.errors, status: :unprocessable_entity }
                format.html  { render :index }
            end
        else
            respond_to do |format|
                format.json { render json: @lessons.errors, status: :unprocessable_entity }
                format.html  { redirect_to courses_path, flash: {danger: "Please select a course."} }
            end
        end
    end

    # GET course/:course_id/lessons/:id
    def show
        respond_to do |format|
            format.json { render json: {message: "Lesson retrieved with id: #{params[:id]}", data: @lesson}, status: :ok}
            format.html { render :show} 
        end
    end

    def edit
    end

    def new
        @lesson = Lesson.new
    end


    # #POST /lessons
    # def create 
    #     @lesson = Lesson.new(lesson_params)
    #     @lesson.save
    #     render json: @lesson, status: :created
    # end

    def update
        respond_to do |format|
            if @lesson.update(lesson_params)
                format.html { redirect_to course_lesson_path(@course, @lesson), flash: {info: 'Lesson was successfully updated.'} }
                format.json { render json: {message: "Lesson Updated with id: #{@lesson[:id]}", data: @lesson}, status: :ok }
            else
                format.html { render :edit }
                format.json { render json: @course.errors, status: :unprocessable_entity }
            end
        end
    end

    #DELETE /courses/:course_id/lessons/:id
    def destroy
        respond_to do |format|
            if @lesson.destroy
                format.html { redirect_to course_lessons_path(@course), flash: {info: 'Lesson was successfully deleted.'} }
                format.json { render json: {message: "Lesson Deleted with id: #{@lesson[:id]}"}, status: :ok }
            else
                format.html { render :index }
                format.json { render json: @lesson.errors, status: :unprocessable_entity }
            end
        end
        
    end

    # #DELETE /lessons/:id
    # def destroy
    #     @lesson = Lesson.find(params[:id])
    #     @lesson.destroy
    #     render json: @lesson, status: :ok
    # end

    private
    def lesson_params
        params.require(:lesson).permit(:title, :image_url, :course_id)
    end
end
