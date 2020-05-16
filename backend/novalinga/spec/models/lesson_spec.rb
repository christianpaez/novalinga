require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it "should validate presence of fields" do
    should validate_presence_of(:title)
    should validate_presence_of(:image_url)
    should validate_presence_of(:course_id)
  end
end
