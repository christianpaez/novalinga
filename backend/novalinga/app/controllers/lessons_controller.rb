class LessonsController < ApplicationController
    include ApplicationHelper
    before_action :require_login, only: [:index, :show]
    # GET /lessons
    def index
        course_id =  params[:course_id]
        if course_id
            @lessons = Lesson.where(course_id: course_id)
        else
            @lessons = Lesson.all
        end

        render json: {message: "Lessons retrieved", data: @lessons}, status: :ok
    end

    # GET /lessons/:id
    def show
        @lesson = Lesson.find(params[:id]) 
        render json: {message: "Lesson retrieved with id: #{params[:id]}", data: @lesson}, status: :ok
    end

    # #POST /lessons
    # def create 
    #     @lesson = Lesson.new(create_params)
    #     @lesson.save
    #     render json: @lesson, status: :created
    # end

    # # PUT /lessons/:id
    # def update
    #     @lesson = Lesson.find(params[:id])
    #     @lesson.update!(update_params)
    #     render json: @lesson, status: :ok
    # end

    # #DELETE /lessons/:id
    # def destroy
    #     @lesson = Lesson.find(params[:id])
    #     @lesson.destroy
    #     render json: @lesson, status: :ok
    # end

    private
    def create_params
        params.require(:lesson).permit(:title, :image_url, :course_id)
    end

    private
    def update_params
        params.require(:lesson).permit(:title, :image_url)
    end
end
