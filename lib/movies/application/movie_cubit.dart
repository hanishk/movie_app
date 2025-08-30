import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/application/movie_state.dart';
import 'package:movie_app/movies/domain/entities/movie.dart';
import 'package:movie_app/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app/movies/domain/usecases/get_bookmark_movies.dart';
import 'package:movie_app/movies/domain/usecases/get_movie_details.dart';
import '../domain/usecases/get_trending_movies.dart';
import '../domain/usecases/get_now_playing_movies.dart';
import '../domain/usecases/search_movies.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetTrendingMovies getTrendingMovies;
  final GetNowPlayingMovies getNowPlayingMovies;
  final SearchMovies searchMovies;
  final GetMovieDetails movieDetails;
  final BookmarkMovies getBookmarkMovies;

  MovieCubit(
    this.getTrendingMovies,
    this.getNowPlayingMovies,
    this.searchMovies,
    this.movieDetails,
    this.getBookmarkMovies,
  ) : super(MovieState());

  Future<void> fetchTrending() async {
    emit(state.copyWith(isTrendingLoading: true));
    try {
      final movies = await getTrendingMovies();
      emit(state.copyWith(trending: movies, isTrendingLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isTrendingLoading: false));
    }
  }

  Future<void> fetchNowPlaying() async {
    emit(state.copyWith(isNowPlayingLoading: true));
    try {
      final movies = await getNowPlayingMovies();
      emit(state.copyWith(nowPlaying: movies, isNowPlayingLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isNowPlayingLoading: false));
    }
  }

  Future<void> fetchSearchMovies(String query) async {
    emit(state.copyWith(isSearchLoading: true));
    try {
      final results = await searchMovies(query);
      emit(state.copyWith(searchResults: results, isSearchLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isSearchLoading: false));
    }
  }

  Future<void> fetchMovieDetails(int id) async {
    emit(state.copyWith(isDetailsLoading: true));
    try {
      final movie = await movieDetails(id);
      emit(state.copyWith(selectedMovie: movie, isDetailsLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isDetailsLoading: false));
    }
  }

  Future<void> loadBookmarks() async {
    final saved = await getBookmarkMovies.getAllBookMarkedMovies();
    emit(state.copyWith(bookmarks: saved));
  }

  Future<void> addBookmark(Movie movie) async {
    await getBookmarkMovies.addBookMarkMovies(movie);
    loadBookmarks();
  }

  Future<void> removeBookmark(int id) async {
    await getBookmarkMovies.removeBookMarkMovie(id);
    loadBookmarks();
  }
}
