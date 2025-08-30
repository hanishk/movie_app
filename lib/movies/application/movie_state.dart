import 'package:movie_app/movies/domain/entities/movie.dart';

class MovieState {
  final List<Movie> trending;
  final List<Movie> nowPlaying;
  final List<Movie> searchResults;
  final Movie? selectedMovie;
  final String error;
  final bool isTrendingLoading;
  final bool isNowPlayingLoading;
  final bool isSearchLoading;
  final bool isDetailsLoading;

  MovieState({
    this.trending = const [],
    this.nowPlaying = const [],
    this.searchResults = const [],
    this.selectedMovie,
    this.error = '',
    this.isTrendingLoading = false,
    this.isNowPlayingLoading = false,
    this.isSearchLoading = false,
    this.isDetailsLoading = false,
  });

  MovieState copyWith({
    List<Movie>? trending,
    List<Movie>? nowPlaying,
    List<Movie>? searchResults,
    String? error,
    Movie? selectedMovie,
    bool? isTrendingLoading,
    bool? isNowPlayingLoading,
    bool? isSearchLoading,
    bool? isDetailsLoading,
  }) {
    return MovieState(
      trending: trending ?? this.trending,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      searchResults: searchResults ?? this.searchResults,
      selectedMovie: selectedMovie ?? this.selectedMovie,
      error: error ?? this.error,
      isTrendingLoading: isTrendingLoading ?? this.isTrendingLoading,
      isNowPlayingLoading: isNowPlayingLoading ?? this.isNowPlayingLoading,
      isSearchLoading: isSearchLoading ?? this.isSearchLoading,
      isDetailsLoading: isDetailsLoading ?? this.isDetailsLoading,
    );
  }
}
