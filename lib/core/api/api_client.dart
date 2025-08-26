import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() {
    return 'ApiException: $message (Status Code: $statusCode)';
  }
}

class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({required this.baseUrl}) : _client = http.Client();

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    try {
      final response = await _client.get(uri, headers: _mergedHeaders(headers));
      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No Internet connection', 0);
    } on HttpException {
      throw ApiException('Could not find the server', 0);
    } catch (e) {
      throw ApiException('An unknown error occurred: $e', 0);
    }
  }

  Map<String, String> _mergedHeaders(Map<String, String>? headers) {
    final defaultHeaders = {'Content-Type': 'application/json; charset=UTF-8'};
    if (headers != null) {
      defaultHeaders.addAll(headers);
    }
    return defaultHeaders;
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isEmpty) {
        return null;
      }
      return json.decode(response.body);
    } else {
      throw ApiException('Request failed with status: $statusCode', statusCode);
    }
  }

  void close() {
    _client.close();
  }
}
