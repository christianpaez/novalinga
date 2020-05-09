class Lesson < ApplicationRecord
  belongs_to :course
  validates :title, presence: true
  validates :image_url, presence: true
  validates :course_id, presence: true
end
