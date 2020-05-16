require 'rails_helper'

RSpec.describe UsersCourse, type: :model do
  describe "validations" do
    it "should validate presence of fields" do
      should validate_presence_of(:user_id)
      should validate_presence_of(:course_id)
    end
  end
end
