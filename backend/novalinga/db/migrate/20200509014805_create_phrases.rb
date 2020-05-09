class CreatePhrases < ActiveRecord::Migration[6.0]
  def change
    create_table :phrases do |t|
      t.string :input_language
      t.string :output_language
      t.string :phonetic
      t.string :audio_url
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
