require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "should validate presence of fields" do
      should validate_presence_of(:email)
      should validate_presence_of(:password)
      should validate_presence_of(:username)
    end
  end
end
