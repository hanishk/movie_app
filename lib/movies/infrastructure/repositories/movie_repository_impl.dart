import 'package:movie_app/movies/infrastructure/datasources/movie_db_helper.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_api_service.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService apiService;
  final MovieDbHelper dbHelper;

  MovieRepositoryImpl(this.apiService, this.dbHelper);

  @override
  Future<List<Movie>> getTrendingMovies() async {
    try {
      final trendingMovies = await apiService.fetchMovies("trending/movie/day");
      await dbHelper.clearMovies();
      await dbHelper.insertMovies(trendingMovies);
      return trendingMovies;
    } catch (e) {
      return await dbHelper.getMovies();
    }
  }

  @override
  Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final nowPlayingMovies = await apiService.fetchMovies(
        "movie/now_playing",
      );
      await dbHelper.insertMovies(nowPlayingMovies);
      return nowPlayingMovies;
    } catch (e) {
      return await dbHelper.getMovies();
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      final searchedMovies = await apiService.fetchMovies(
        "search/movie",
        params: {"query": query},
      );
      return searchedMovies;
    } catch (_) {
      final all = await dbHelper.getMovies();
      return all
          .where((m) => m.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Future<Movie> getMovieDetails(int id) async {
    try {
      final movieDetails = await apiService.fetchMovieDetails(id);
      return movieDetails;
    } catch (e) {
      final all = await dbHelper.getMovies();
      return all.firstWhere((m) => m.id == id);
    }
  }
}
