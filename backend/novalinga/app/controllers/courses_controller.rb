class CoursesController < ApplicationController
    include ApplicationHelper
    include CoursesHelper
    before_action :require_login, only: [:index, :show], :unless => :html_request?
    before_action :set_course, only: [:show, :edit, :update, :destroy], :if => :html_request?
    # GET /courses
    def index
        @courses = Course.all
        respond_to do |format|
            format.json { render json: {message: "Courses retrieved", data: @courses}, status: :ok }
            format.html  { render :index}
        end
    end

    # GET /courses/:id
    def show
        respond_to do |format|
            format.json { render json: {message: "Course retrieved with id: #{params[:id]}", data: @course}, status: :ok }
            format.html { render :show} 
        end
    end

    def new
        @course = Course.new
    end

    def edit
        
    end

    # #POST /courses
    def create 
        @course = Course.new(course_params)
        respond_to do |format|
            if @course.save
              format.html { redirect_to @course, notice: 'Course was successfully created.' }
              format.json { render json: @course, status: :created }
            else
              format.html { render :new }
              format.json { render json: @course.errors, status: :unprocessable_entity }
            end
          end
    end

    # # PUT /courses/:id
    def update
        respond_to do |format|
            if @course.update(course_params)
                format.html { redirect_to @course, flash: {info: 'Course was successfully updated.'} }
                format.json { render json: {message: "Course Updated with id: #{@course[:id]}", data: @course}, status: :ok }
            else
                format.html { render :edit }
                format.json { render json: @course.errors, status: :unprocessable_entity }
            end
        end
    end

    # #DELETE /courses/:id
    def destroy
        respond_to do |format|
            if @course.destroy
                format.html { redirect_to courses_path, flash: {info: 'Course was successfully deleted.'} }
                format.json { render json: {message: "Course Deleted with id: #{@course[:id]}"}, status: :ok }
            else
                format.html { render :index }
                format.json { render json: @course.errors, status: :unprocessable_entity }
            end
        end
        
    end

    private
    def course_params
        params.require(:course).permit(:title, :image_url, :input_language, :output_language)
    end
end
