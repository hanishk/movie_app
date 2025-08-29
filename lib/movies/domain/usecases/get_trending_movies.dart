// get_trending_movies.dart
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTrendingMovies {
  final MovieRepository repository;
  GetTrendingMovies(this.repository);

  Future<List<Movie>> call() => repository.getTrendingMovies();
}
