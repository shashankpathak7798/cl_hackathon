import 'dart:async';
import 'dart:convert';

import 'package:cl_hackathon/core/network/custom_exception.dart';
import 'package:cl_hackathon/core/network/log.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String baseUrl = "https://treefrog-vocal-eagerly.ngrok-free.app";

  /// Get data with optional authorization
  Future<dynamic> getData({
    required String url,
    Map<String, dynamic>? body,
    void Function(int, String)? setResponseStatus,
  }) async {
    dynamic responseJson;
    try {
      final headers = await _buildHeaders();

      final response = await http.post(
        Uri.parse('$baseUrl$url'),
        headers: headers,
        body: json.encode(body),
      );

      setResponseStatus?.call(
          response.statusCode, jsonDecode(response.body)['message'] ?? '');

      Log.debug('API ${baseUrl + url} STATUS CODE = ${response.statusCode}');
      Log.debug('PAYLOAD = $body');
      Log.debug('Get Data Response: ${response.body}');

      responseJson = _processResponse(response);

      if (responseJson == null) return null;
      return responseJson;
    } on TimeoutException catch (e, s) {
      Log.error("ApiProvider get $url failed with timeout for $baseUrl$url",
          error: e, stackTrace: s);
      return null;
    } catch (e, s) {
      Log.error(
          "ApiProvider get $url failed with error $e for url $baseUrl$url",
          error: e,
          stackTrace: s);
      return null;
    }
  }

  /// Build headers with optional authorization
  Future<Map<String, String>> _buildHeaders() async {
    final headers = <String, String>{
      "Content-Type": "application/json",
    };

    return headers;
  }

  /// Process API response
  dynamic _processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(response.body);
      case 400:
        Log.error("Bad Request: ${response.body}");
        throw BadRequestException(
          jsonDecode(response.body)['message'] ?? 'Bad request',
        );
      case 401:
        throw UnauthorisedException(
          jsonDecode(response.body)['message'] ?? 'Unauthorised',
        );
      case 403:
        Log.error("Forbidden Error: ${jsonDecode(response.body)['message']}");
        throw UnauthorisedException(
          jsonDecode(response.body)['message'] ?? 'Forbidden',
        );
      case 500:
        Log.error(
            "Internal Server Error: ${jsonDecode(response.body)['message']}");
        throw FetchDataException(
          jsonDecode(response.body)['message'] ?? 'Internal server error',
        );
      default:
        Log.error("Error occurred: ${jsonDecode(response.body)}");
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}
