import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GameApiService {
  final String baseUrl = "https://api.rawg.io/api";

  Future<Map<String, dynamic>> getJson(String endpoint) async {
    final apiKey = dotenv.env['RAWG_API_KEY'];

    final url = Uri.parse("$baseUrl/$endpoint&key=$apiKey");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error al conectar con RAWG API");
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> searchGames(String query) async {
    final apiKey = dotenv.env['RAWG_API_KEY'];

    final url = Uri.parse("$baseUrl/games?search=$query&key=$apiKey");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Error al buscar juegos");
    }

    return jsonDecode(response.body);
  }
}
