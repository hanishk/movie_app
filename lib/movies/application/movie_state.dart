import 'package:movie_app/movies/domain/entities/movie.dart';

class MovieState {
  final List<Movie> trending;
  final List<Movie> nowPlaying;
  final List<Movie> searchResults;
  final Movie? selectedMovie;
  final bool isLoading;
  final String error;

  MovieState({
    this.trending = const [],
    this.nowPlaying = const [],
    this.searchResults = const [],
    this.selectedMovie,
    this.isLoading = false,
    this.error = '',
  });

  MovieState copyWith({
    List<Movie>? trending,
    List<Movie>? nowPlaying,
    List<Movie>? searchResults,
    bool? isLoading,
    String? error,
    Movie? selectedMovie,
  }) {
    return MovieState(
      trending: trending ?? this.trending,
      nowPlaying: nowPlaying ?? this.nowPlaying,
      searchResults: searchResults ?? this.searchResults,
      selectedMovie: selectedMovie ?? this.selectedMovie,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
