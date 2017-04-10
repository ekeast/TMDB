class RemoveImdbFromMovies < ActiveRecord::Migration[5.0]
  def change
    remove_column :movies, :imdb, :string
  end
end
