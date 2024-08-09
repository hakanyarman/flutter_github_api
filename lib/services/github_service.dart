import 'dart:convert';
import 'package:http/http.dart' as http;

// MVVM Architecture (MVC - MVI - MVVM)
// Screen -> ViewModel -> UseCase -> Repository -> Service

class GithubService {
  final String baseUrl = 'https://api.github.com';

  // Return type: List<User>
  // Header ekleyelim
  Future<List<dynamic>> getFollowers(String username) async {
    final response =
        await http.get(Uri.parse('$baseUrl/users/$username/followers'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load followers');
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String username) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$username'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user info');
    }
  }
}