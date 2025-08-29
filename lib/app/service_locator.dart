import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app/movies/domain/usecases/get_movie_details.dart';
import 'package:movie_app/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_app/movies/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/movies/domain/usecases/search_movies.dart';
import 'package:movie_app/movies/infrastructure/datasources/movie_api_service.dart';
import 'package:movie_app/movies/infrastructure/repositories/movie_repository_impl.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Dio client
  sl.registerLazySingleton<Dio>(() => Dio());

  // API service
  sl.registerLazySingleton<MovieApiService>(() => MovieApiService());

  // Repository
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetTrendingMovies(sl()));
  sl.registerLazySingleton(() => GetNowPlayingMovies(sl()));
  sl.registerLazySingleton(() => SearchMovies(sl()));
  sl.registerLazySingleton(() => GetMovieDetails(sl()));
}
