require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "validations" do
    it "should validate presence of fields" do
      should validate_presence_of(:input_language)
      should validate_presence_of(:output_language)
      should validate_presence_of(:title)
      should validate_presence_of(:image_url)
    end
  end
end
