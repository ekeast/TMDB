# README

The application was built by making an API request to TMDB for movies with release dates that were within the last 14 days in Greece.

As it loops through the "Now Playing" movies, it checks the TMDB movie ID to see whether or not that movie is already logged in the database.

If there is not a movie with that THDB ID, it creates the movie, issuing another HTTP request to get the movie's directors. Then it issues another HTTP request for each director to retrieve his/her IMDB code.

Each movie, its director, and the director's corresponding IMDB code are stored as a Movie object in the database.

Every time the page loads, a new HTTP request is issued for a movie with a release date within the last 14 days, and if there are movies that are not in the database already, those movies are added.
