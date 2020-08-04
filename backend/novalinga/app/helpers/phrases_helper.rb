module PhrasesHelper
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson_and_course
        @lesson = Lesson.find(params[:lesson_id])
        @course = Course.find(params[:course_id])
    end

    def set_phrase
        @phrase = Phrase.find(params[:id])
    end
end
