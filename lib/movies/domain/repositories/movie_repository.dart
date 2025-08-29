import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getTrendingMovies();
  Future<List<Movie>> getNowPlayingMovies();
  Future<Movie> getMovieDetails(int id);
  Future<List<Movie>> searchMovies(String query);
}
