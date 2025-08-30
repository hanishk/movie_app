import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/movies/application/movie_state.dart';
import '../../application/movie_cubit.dart';
import '../widgets/movie_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Inshort Movies",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              context.push('/search');
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.white),
            onPressed: () => context.push('/bookmarks'),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<MovieCubit, MovieState>(
        builder: (context, state) {
          if (state.isTrendingLoading || state.isNowPlayingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error.isNotEmpty) {
            return Center(
              child: Text(
                state.error,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildMovieSection(
                  context,
                  title: "Trending",
                  movies: state.trending,
                ),
                buildMovieSection(
                  context,
                  title: "Now Playing",
                  movies: state.nowPlaying,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildMovieSection(
    BuildContext context, {
    required String title,
    required List movies,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: MovieCard(movie: movies[index]),
                  ),
              itemCount: movies.length,
            ),
          ),
        ],
      ),
    );
  }
}
