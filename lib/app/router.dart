import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/app/service_locator.dart';
import 'package:movie_app/movies/application/movie_cubit.dart';
import 'package:movie_app/movies/domain/usecases/get_movie_details.dart';
import 'package:movie_app/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_app/movies/domain/usecases/get_trending_movies.dart';
import 'package:movie_app/movies/domain/usecases/search_movies.dart';
import 'package:movie_app/movies/presentation/pages/home_page.dart';
import 'package:movie_app/movies/presentation/pages/movie_detail_page.dart';


class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return BlocProvider(
            create: (_) => MovieCubit(
              sl<GetTrendingMovies>(),
              sl<GetNowPlayingMovies>(),
              sl<SearchMovies>(),
              sl<GetMovieDetails>(),
            )..fetchTrending()..fetchNowPlaying(),
            child: const HomePage(),
          );
        },
      ),
      // Movie Details route
      GoRoute(
  path: '/movie/:id',
  builder: (context, state) {
    final movieId = int.parse(state.pathParameters['id']!);

    // Reuse existing MovieCubit (from HomePage provider)
    return BlocProvider(
      create: (_) => MovieCubit(
              sl<GetTrendingMovies>(),
              sl<GetNowPlayingMovies>(),
              sl<SearchMovies>(),
              sl<GetMovieDetails>(),
            )..fetchMovieDetails(movieId),
      child: MovieDetailsPage(movieId: movieId),
    );
  },
),

      
    ],
  );
}
