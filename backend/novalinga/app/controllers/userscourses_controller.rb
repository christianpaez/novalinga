class UserscoursesController < ApplicationController
  include ApplicationHelper
  before_action :require_login, only: [:create, :destroy]

  def to_param
    course_id
  end
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
  def create 
    @userscourse = Userscourse.new(userscourse_params)
    if @userscourse.save!
      render json: {
        message: "Created Userscourse with id:#{@userscourse.id}", 
        data: @userscourse}, status: :created
    else
      render json: {
        message: "Error deleting Userscourse with id:#{@userscourse.id}", 
        error: @userscourse.errors}, status: 422
    end
  end

  # # PUT /userscourses/:id
  # def update
  #   @userscourse = Userscourse.find(params[:id])
  #   @userscourse.update!(userscourse_params)
  #   render json: @userscourse, status: :ok
  # end

  # #DELETE /userscourses/:id
  def destroy
    @userscourse = Userscourse.where("course_id" =>  params[:course_id]).where("user_id": @user.id).take()
    if @userscourse
       if @userscourse.destroy!
          render json: {
            message: "Userscourse deleted with id:#{@userscourse.id}", 
          }, status: :ok
       else
        render json: {
          message: "Cannot delete Userscourse with id:#{@userscourse.id}", 
          errors: @userscourse.errors
          }, status: :unprocessable_entity
       end
    else
      render json: {
        message: "Cannot find Userscourse with id:#{@userscourse.id}", 
        errors: @userscourse.errors
        }, status: :unprocessable_entity
    end
  end

  private
  def userscourse_params
    params.require(:userscourse).permit(:user_id, :course_id)
  end
end
