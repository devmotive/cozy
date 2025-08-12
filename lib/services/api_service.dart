import 'dart:convert';

import 'package:cozy/models/space.dart';
import 'package:http/http.dart' as http;

// Service class for handling API requests.
class ApiService {
  final String _baseUrl = 'https://bwa-cozy-api.vercel.app/recommended-spaces';

  // Fetches recommended spaces from the API.
  Future<List<Space>> getRecommendedSpaces() async {
    // Make a GET request to the API.
    final response = await http.get(Uri.parse(_baseUrl));

    // Check if the request was successful (status code 200).
    if (response.statusCode == 200) {
      // Parse the JSON response body.
      List data = jsonDecode(response.body);
      // Map the JSON data to a list of Space objects.
      List<Space> spaces = data.map((item) => Space.fromJson(item)).toList();
      return spaces;
    } else {
      // Throw an exception if the request failed.
      throw Exception('Failed to load recommended spaces');
    }
  }
}
