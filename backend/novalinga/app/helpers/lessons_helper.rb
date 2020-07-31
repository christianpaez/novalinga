module LessonsHelper
    # Use callbacks to share common setup or constraints between actions.
    def set_course
        @course = Course.find(params[:course_id])
    end

    def set_lesson
        @lesson = Lesson.find(params[:id])
    end
end
