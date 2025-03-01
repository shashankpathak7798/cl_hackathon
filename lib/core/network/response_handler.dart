import 'dart:io';
import 'package:cl_hackathon/core/network/log.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ResponseHandler {
  Future<dynamic> responseHandlerFun<T>({
    required Response response,
    required String urlPath,
    required Function fun,
    String? cacheKey,
    void Function(int)? statusCode,
  }) async {
    try {
      debugPrint("response.body ${response.body}");
      statusCode?.call(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        Log.logger.d('$urlPath ($T)\'s API CALL SUCCESS');

        Log.logger.d('Success API -> $urlPath');
        return fun(response.body);
      } else if (response.statusCode >= 300 && response.statusCode <= 400) {
        final message = 'Bad Request API -> $urlPath';
        Log.logger.d(message);
        return fun(response.body);
      } else if (response.statusCode == 401) {
        final message = 'Unauthorized API -> $urlPath';
        Log.logger.d(message);
        return fun(response.body);
      } else if (response.statusCode > 401 && response.statusCode < 500) {
        final message = 'Unknown Error -> $urlPath';
        Log.logger.d(message);
        return fun(response.body);
      } else if (response.statusCode >= 500) {
        final message = 'Server Error API -> $urlPath';
        Log.logger.d(message);
        return fun(response.body);
      } else {
        throw Exception();
      }
    } on SocketException catch (e) {
      Log.logger.e('SocketException = $e');
      return e;
    } on HttpException catch (e) {
      Log.logger.e('HttpException = $e');
      return e;
    } on ClientException catch (e) {
      Log.logger.e('ClientException = $e');
      return e;
    } on FormatException catch (e) {
      Log.logger.e('FormatException = ${response.body} $e');
      return fun(response.body);
    } catch (e) {
      Log.logger.e('Something went wrong in this API $urlPath :- $e');
      return e;
    }
  }
}
