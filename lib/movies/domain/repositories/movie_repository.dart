import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendingMovies();
  Future<List<Movie>> getNowPlayingMovies();
  Future<Movie> getMovieDetails(int id);
  Future<List<Movie>> searchMovies(String query);
  Future<void> bookmarkMovie(Movie movie);
  Future<void> removeBookmark(int id);
  Future<List<Movie>> getBookmarks();
}
