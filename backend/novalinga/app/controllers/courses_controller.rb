class CoursesController < ApplicationController
    include ApplicationHelper
    include CoursesHelper
    before_action :require_login, only: [:index, :show], :unless => :html_request?
    before_action :authenticate_admin!, :if => :html_request?
    before_action :set_course, only: [:show, :edit], :if => :html_request?
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

    def edit
        
    end

    # #POST /courses
    # def create 
    #     @course = Course.new(course_params)
    #     @course.save
    #     render json: @course, status: :created
    # end

    # # PUT /courses/:id
    # def update
    #     @course = Course.find(params[:id])
    #     @course.update!(course_params)
    #     render json: @course, status: :ok
    # end

    # #DELETE /courses/:id
    # def destroy
    #     @course = Course.find(params[:id])
    #     @course.destroy
    #     render json: @course, status: :ok
    # end

    private
    def course_params
        params.require(:course).permit(:title, :image_url, :input_language, :output_language)
    end
end
