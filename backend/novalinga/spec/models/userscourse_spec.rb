require 'rails_helper'

RSpec.describe Userscourse, type: :model do
  it "should validate presence of fields" do
    should validate_presence_of(:user_id)
    should validate_presence_of(:course_id)
  end
end
