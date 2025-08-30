import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class BookmarkMovies {
  final MovieRepository repository;

  BookmarkMovies(this.repository);

  Future<List<Movie>> getAllBookMarkedMovies() {
    return repository.getBookmarks();
  }

  Future<void> addBookMarkMovies(Movie movie) {
    return repository.bookmarkMovie(movie);
  }

  Future<void> removeBookMarkMovie(int id) {
    return repository.removeBookmark(id);
  }
}
