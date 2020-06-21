class UserscoursesController < ApplicationController
  # # GET /userscourses
  # def index
  #   @userscourses = Userscourse.all
  #   render json: @userscourses, status: :ok
  # end

  # # GET /userscourses/:id
  # def show
  #   @userscourse = Userscourse.find(params[:id]) 
  #   render json: @userscourse, status: :ok
  # end

  # #POST /userscourses
  # def create 
  #   @userscourse = Userscourse.new(userscourse_params)
  #   @userscourse.save
  #   render json: @userscourse, status: :created
  # end

  # # PUT /userscourses/:id
  # def update
  #   @userscourse = Userscourse.find(params[:id])
  #   @userscourse.update!(userscourse_params)
  #   render json: @userscourse, status: :ok
  # end

  # #DELETE /userscourses/:id
  # def destroy
  #   @userscourse = Userscourse.find(params[:id])
  #   @userscourse.destroy
  #   render json: @userscourse, status: :ok
  # end

  private
  def userscourse_params
    params.require(:userscourse).permit(:user_id, :course_id)
  end
end
