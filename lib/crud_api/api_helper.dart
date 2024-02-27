import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl = 'http://54.210.15.138/'; // Replace with your API base URL

  static Future<dynamic> get({required String endpoint}) async {
    //connecting baseurl+endpoint
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    return _handleResponse(response);
  }
//
//
//
//
//
  static Future<dynamic> post({required String endpoint, Map? data}) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

//
//
//
//
//
  static Future<dynamic> patch({required String endpoint, dynamic data}) async {
    final response = await http.patch(
      Uri.parse('$baseUrl$endpoint'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

//
//
//
//
//
  static Future<dynamic> put({required String endpoint, Map? data}) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

//
//
//
//
//
  static Future<dynamic> delete({required endpoint}) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint'));
    return _handleResponse(response);
  }

//
//
//
//
//
  static dynamic _handleResponse(http.Response response) {
    print(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Success
      print(response.body);
      return jsonDecode(response.body);
    } else {
      // Error
      return null;
    }
  }
}
