import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/application/movie_state.dart';
import 'package:movie_app/movies/domain/usecases/get_movie_details.dart';
import '../domain/usecases/get_trending_movies.dart';
import '../domain/usecases/get_now_playing_movies.dart';
import '../domain/usecases/search_movies.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetTrendingMovies getTrendingMovies;
  final GetNowPlayingMovies getNowPlayingMovies;
  final SearchMovies searchMovies;
  final GetMovieDetails movieDetails;

  MovieCubit(
    this.getTrendingMovies,
    this.getNowPlayingMovies,
    this.searchMovies,
    this.movieDetails,
  ) : super(MovieState());

  Future<void> fetchTrending() async {
    emit(state.copyWith(isLoading: true));
    try {
      final movies = await getTrendingMovies();
      emit(state.copyWith(trending: movies, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchNowPlaying() async {
    emit(state.copyWith(isLoading: true));
    try {
      final movies = await getNowPlayingMovies();
      emit(state.copyWith(nowPlaying: movies, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchSearchMovies(String query) async {
    emit(state.copyWith(isLoading: true));
    try {
      final results = await searchMovies(query);
      emit(state.copyWith(searchResults: results, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> fetchMovieDetails(int id) async {
    emit(state.copyWith(isLoading: true));
    try {
      final movie = await movieDetails(id);
      emit(state.copyWith(selectedMovie: movie, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
