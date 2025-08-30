// lib/movies/presentation/pages/movie_details_page.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/application/movie_cubit.dart';
import 'package:movie_app/movies/application/movie_state.dart';
import 'package:share_plus/share_plus.dart';

class MovieDetailsPage extends StatefulWidget {
  final int movieId;

  const MovieDetailsPage({super.key, required this.movieId});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieCubit>().fetchMovieDetails(widget.movieId);
    context.read<MovieCubit>().loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // title: const Text("", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: () {
              final movie = context.read<MovieCubit>().state.selectedMovie;
              if (movie != null) {
                final deepLink = "movieapp://movie/${movie.id}";
                SharePlus.instance.share(
                  ShareParams(
                    text: 'Check out this movie: ${movie.title}\n$deepLink',
                  ),
                );
              }
            },
          ),
          BlocBuilder<MovieCubit, MovieState>(
            builder: (context, state) {
              final movie = state.selectedMovie;
              if (movie == null) return const SizedBox.shrink();

              final isBookmarked = state.bookmarks.any((m) => m.id == movie.id);

              return IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (isBookmarked) {
                    context.read<MovieCubit>().removeBookmark(movie.id);
                  } else {
                    context.read<MovieCubit>().addBookmark(movie);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state.isDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.error.isNotEmpty) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              final movie = state.selectedMovie;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://image.tmdb.org/t/p/w500${movie?.posterPath}",
                          fit: BoxFit.cover,
                          width: double.infinity, // ✅ fills full width
                          placeholder:
                              (context, url) => Container(
                                color: Colors.grey[900],
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Container(
                                color: Colors.grey[800],
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.white,
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      movie?.title ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Release Date: ${movie?.releaseDate ?? ''}",
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      movie?.overview ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
