import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/photo.dart';

class ApiClient {
  final String baseUrl = 'https://picsum.photos';

  Future<List<Photo>> fetchPhotos({int limit = 10}) async {
    final response = await http.get(Uri.parse('$baseUrl/v2/list?page=1&limit=$limit'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }
}