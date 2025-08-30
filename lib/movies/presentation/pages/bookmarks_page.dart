// lib/movies/presentation/pages/bookmarks_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/movies/application/movie_cubit.dart';
import 'package:movie_app/movies/application/movie_state.dart';
import '../widgets/movie_card.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MovieCubit>().loadBookmarks();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Saved Movies",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state.bookmarks.isEmpty) {
            return const Center(
              child: Text(
                "No bookmarks yet!",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 movies per row
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.65,
            ),
            itemCount: state.bookmarks.length,
            itemBuilder: (context, index) {
              final movie = state.bookmarks[index];
              print("bookmarked movie: ${movie.title}");
              return MovieCard(movie: movie);
            },
          );
        },
      ),
    );
  }
}
