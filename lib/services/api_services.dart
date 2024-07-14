import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<List<dynamic>> listRestaurant() async {
    final response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData['restaurants'];
    } else {
      throw Exception('Gagal load restaurant');
    }
  }
}
