class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :description
      t.string :original_title
      t.string :director
      t.string :imdb

      t.timestamps
    end
  end
end
