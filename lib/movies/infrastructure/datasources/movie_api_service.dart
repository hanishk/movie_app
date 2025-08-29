import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie_model.dart';

class MovieApiService {
  final String baseUrl = "https://api.themoviedb.org/3";
  final String apiKey = "ac927fffe04c302ba7c2e6bc2cbb79ce";

  http.Client? _client;

  Future<List<MovieModel>> fetchMovies(
    String endpoint, {
    Map<String, String>? params,
  }) async {
    _client?.close();
    _client = http.Client();

    final queryParams = {"api_key": apiKey, ...?params};
    final uri = Uri.parse(
      "$baseUrl/$endpoint",
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("data: $data");
      return (data['results'] as List)
          .map((e) => MovieModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to fetch movies");
    }
  }

  Future<MovieModel> fetchMovieDetails(int id) async {
    final response = await http.get(
      Uri.parse("$baseUrl/movie/$id?api_key=$apiKey"),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return MovieModel.fromJson(data);
    } else {
      throw Exception("Failed to fetch movies");
    }
  }
}
