require 'open-uri'
require 'json'
require 'net/http'

class HomeController < ApplicationController
  def index
    today = Date.today.to_s
    past = (Date.today - 14).to_s
    url = 'https://api.themoviedb.org/3/discover/movie?api_key=' + ENV['TMDB_API'] + '&region=GR&release_date.gte=' + past + '&release_date.lte=' + today
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @movies = JSON.parse(response)
    unless @movies['results'].nil?
      @movies['results'].each do |movie|
        if Movie.where(tmdbid: movie['id'].to_i).empty?
          crew_url = 'https://api.themoviedb.org/3/movie/' + movie['id'].to_s + '/credits?api_key=bbb0e77b94b09193e6f32d5fac7a3b9c'
          crew_uri = URI(crew_url)
          crew_response = Net::HTTP.get(crew_uri)
          crew_hash = JSON.parse(crew_response)
          directors = []
          unless crew_hash['crew'].nil?
            crew_hash['crew'].each do |member|
              if member['job'] == 'Director'
                directors.push(member['name'])
                director_url = 'https://api.themoviedb.org/3/person/' + member['id'].to_s + '?api_key=bbb0e77b94b09193e6f32d5fac7a3b9c&language=en-US'
                director_uri = URI(director_url)
                director_response = Net::HTTP.get(director_uri)
                director_hash = JSON.parse(director_response)
                directors.push(director_hash['imdb_id'])
              end
            end
          end

          Movie.create(:title => movie['title'], :description => movie['overview'], :original_title => movie['original_title'], :director => directors.join(","), :tmdbid => movie['id'], :release_date => movie['release_date'].to_date)
        end
      end
    end

    Movie.where("release_date < ?", Date.today - 14).destroy_all
    @dbmovies = Movie.all

    respond_to do |format|
      format.html
      format.js
    end
  end
end
