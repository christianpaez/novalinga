class CreatePhonetics < ActiveRecord::Migration[6.0]
  def change
    create_table :phonetics do |t|
      t.string :input_language
      t.string :output_language
      t.string :phonetic
      t.string :audio_url

      t.timestamps
    end
  end
end
