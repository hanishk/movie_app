import 'package:flutter/material.dart';
import 'package:movie_app/app/router.dart';
import 'package:movie_app/app/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Movie App',
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
    );
  }
}
