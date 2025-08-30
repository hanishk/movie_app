import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie_model.dart';

class MovieDbHelper {
  static final MovieDbHelper _instance = MovieDbHelper._internal();
  factory MovieDbHelper() => _instance;
  MovieDbHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'movies.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE movies (
            id INTEGER PRIMARY KEY,
            title TEXT,
            overview TEXT,
            posterPath TEXT,
            releaseDate TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertMovies(List<MovieModel> movies) async {
    final db = await database;
    for (var movie in movies) {
      await db.insert(
        'movies',
        movie.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<MovieModel>> getMovies() async {
    final db = await database;
    final maps = await db.query('movies');
    return maps.map((e) => MovieModel.fromJson(e)).toList();
  }

  Future<void> clearMovies() async {
    final db = await database;
    await db.delete('movies');
  }
}
