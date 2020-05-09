class Course < ApplicationRecord
  validates :title, presence: true
  validates :image_url, presence: true
  validates :input_language, presence: true
  validates :output_language, presence: true
end
