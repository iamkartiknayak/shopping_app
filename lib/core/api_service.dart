import 'package:http/http.dart' as http;

class ApiService {
  Future<String> get(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Failed to load data from $url");
    }
  }
}
