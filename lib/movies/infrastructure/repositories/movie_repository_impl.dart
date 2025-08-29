import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_api_service.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService apiService;

  MovieRepositoryImpl(this.apiService);

  @override
  Future<List<Movie>> getTrendingMovies() =>
      apiService.fetchMovies("trending/movie/day");

  @override
  Future<List<Movie>> getNowPlayingMovies() =>
      apiService.fetchMovies("movie/now_playing");

  @override
  Future<List<Movie>> searchMovies(String query) =>
      apiService.fetchMovies("search/movie", params: {"query": query});
      
  @override
  Future<Movie> getMovieDetails(int id) async{
     final movie = await apiService.fetchMovieDetails(id);
  return movie;
        }
}
