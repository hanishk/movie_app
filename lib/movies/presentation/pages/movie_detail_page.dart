// lib/movies/presentation/pages/movie_details_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/application/movie_cubit.dart';
import 'package:movie_app/movies/application/movie_state.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }  else if (state.error.isNotEmpty) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }else{
              final movie = state.selectedMovie;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/w500${movie?.posterPath}",
                        width: double.infinity,
                        height: 400,
                        fit: BoxFit.cover,
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
