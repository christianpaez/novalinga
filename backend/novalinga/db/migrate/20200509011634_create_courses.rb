class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.string :image_url
      t.string :input_language
      t.string :output_language

      t.timestamps
    end
  end
end
