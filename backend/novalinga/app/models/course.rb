class Course < ApplicationRecord
  validates :title, presence: true
  validates :image_url, presence: true
  validates :input_language, presence: true
  validates :output_language, presence: true

  has_many :userscourses
  has_many :users, through: :userscourses
  has_many :lessons
end
