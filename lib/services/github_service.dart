import 'dart:convert';
import 'package:http/http.dart' as http;

class GithubService {
  final String baseUrl = 'https://api.github.com';

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