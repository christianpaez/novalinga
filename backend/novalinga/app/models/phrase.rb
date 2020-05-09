class Phrase < ApplicationRecord
  belongs_to :lesson
  validates :audio_url, presence: true
  validates :input_language, presence: true
  validates :output_language, presence: true
  validates :phonetic, presence: true
  validates :lesson_id, presence: true
end
