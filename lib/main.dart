import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/app/router.dart';
import 'package:movie_app/app/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MovieApp());
}

class MovieApp extends StatefulWidget {
  const MovieApp({super.key});

  @override
  State<MovieApp> createState() => _MovieAppState();
}

class _MovieAppState extends State<MovieApp> {
  late final GoRouter _router;
  StreamSubscription<Uri>? _linkSub;

  @override
  void initState() {
    super.initState();

    _router = AppRouter.router;

    _initDeepLinks();
  }

  void _initDeepLinks() async {
    final appLinks = AppLinks();

    try {
      // Cold start (app opened with a deep link)
      final initialUri = await appLinks.getInitialLink();
      if (initialUri != null) {
        _handleDeepLink(initialUri);
      }

      // Hot links (when app is already running)
      _linkSub = appLinks.uriLinkStream.listen((uri) {
        if (uri != null) {
          _handleDeepLink(uri);
        }
      });
    } catch (e) {
      debugPrint("Deep link error: $e");
    }
  }

  void _handleDeepLink(Uri uri) {
    if (uri.host == "movies.com" && uri.pathSegments.isNotEmpty) {
      if (uri.pathSegments[0] == "movie") {
        final id = uri.pathSegments[1];
        if (id != null) {
          _router.go("/movie/$id");
        }
      }
    }
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Movie App',
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
