class LessonsController < ApplicationController
    # GET /lessons
    def index
        @lessons = Lesson.all
        render json: @lessons, status: :ok
    end

    # GET /lessons/:id
    def show
        @lesson = Lesson.find(params[:id]) 
        render json: @lesson, status: :ok
    end

    #POST /lessons
    def create 
        @lesson = Lesson.new(create_params)
        @lesson.save
        render json: @lesson, status: :created
    end

    # PUT /lessons/:id
    def update
        @lesson = Lesson.find(params[:id])
        @lesson.update!(update_params)
        render json: @lesson, status: :ok
    end

    #DELETE /lessons/:id
    def destroy
        @lesson = Lesson.find(params[:id])
        @lesson.destroy
        render json: @lesson, status: :ok
    end

    private
    def create_params
        params.require(:lesson).permit(:title, :image_url, :course_id)
    end

    private
    def update_params
        params.require(:lesson).permit(:title, :image_url)
    end
end
