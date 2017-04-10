class AddTmdbidToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :tmdbid, :integer
  end
end
