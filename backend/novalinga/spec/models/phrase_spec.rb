require 'rails_helper'

RSpec.describe Phrase, type: :model do
  describe "validations" do
    it "should validate presence of fields" do
      should validate_presence_of(:input_language)
      should validate_presence_of(:output_language)
      should validate_presence_of(:phonetic)
      should validate_presence_of(:audio_url)
      should validate_presence_of(:lesson_id)
    end
  end
end
