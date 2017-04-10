class Movie < ApplicationRecord
  validates_uniqueness_of :tmdbid
end
