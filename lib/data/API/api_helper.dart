// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// Class representing the response data and error
class ApiResponse {
  final String? stringData;
  final List<String>? errors;
  bool get success => errors == null || errors!.isEmpty;

  const ApiResponse({this.stringData, this.errors});

  @override
  String toString() =>
      'ApiResponse{jsonData: $stringData, error: $errors, success: $success}';
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    var client = super.createHttpClient(context);
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  }
}

// Generic HTTP client class with static methods for common requests
class MyHttpClient {
  static const String baseUrl = 'https://192.168.123.208/api';

  static Future<ApiResponse> get<T>(String endpoint,
      {Map<String, String> headers = const {
        "Access-Control-Allow-Origin":"*",
      }}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final response = await http.get(url, headers: headers);
      return _handleResponse<T>(response);
    } catch (e) {
      return ApiResponse(errors: [e.toString()]);
    }
  }

  static Future<ApiResponse> getParameters<T>(String endpoint,
      {Map<String, String> queryParameters = const {},
      Map<String, String> headers = const {}}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final uriWithParams = url.replace(queryParameters: queryParameters);
    final response = await http.get(uriWithParams, headers: headers);
    return _handleResponse<T>(response);
  }

  static Future<ApiResponse> post<T>(
    String endpoint, {
    required Map<String, dynamic> body,
    Map<String, String> headers = const {},
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: headers,
      body: json.encode(body),
    );
    return _handleResponse<T>(response);
  }

  static Future<ApiResponse> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String> headers = const {},
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.put(
      url,
      headers: headers,
      body: json.encode(body),
    );
    return _handleResponse(response);
  }

  static Future<ApiResponse> delete({
    required String endpoint,
    Map<String, String> headers = const {},
  }) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(url, headers: headers);

    return _handleResponse(response);
  }

  static ApiResponse _handleResponse<T>(http.Response response) {
    var errors = <String>[];
    var successfulStatusCodes = [
      HttpStatus.ok,
      HttpStatus.created,
      HttpStatus.accepted,
      HttpStatus.noContent
    ];
    if (successfulStatusCodes.contains(response.statusCode)) {
      try {
        final data = response.body;
        return ApiResponse(stringData: data);
      } catch (error) {
        errors.add('Failed to decode response: $error');
        return ApiResponse(errors: errors);
      }
    } else {
      errors.add('Request failed with status: ${response.statusCode}');
      return ApiResponse(errors: errors);
    }
  }
}
