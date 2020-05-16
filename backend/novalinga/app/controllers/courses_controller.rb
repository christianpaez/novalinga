class CoursesController < ApplicationController
    # GET /courses
    def index
        @courses = Course.all
        render json: @courses, status: :ok
    end

    # GET /courses/:id
    def show
        @course = Course.find(params[:id]) 
        render json: @course, status: :ok
    end

    #POST /courses
    def create 
        @course = Course.new(course_params)
        @course.save
        render json: @course, status: :created
    end

    # PUT /courses/:id
    def update
        @course = Course.find(params[:id])
        @course.update!(course_params)
        render json: @course, status: :ok
    end

    #DELETE /courses/:id
    def destroy
        @course = Course.find(params[:id])
        @course.destroy
        render json: @course, status: :ok
    end

    private
    def course_params
        params.require(:course).permit(:title, :image_url, :input_language, :output_language)
    end
end