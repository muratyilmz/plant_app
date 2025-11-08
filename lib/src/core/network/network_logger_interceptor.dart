import 'dart:convert';
import 'dart:developer' as developer;

import 'package:dio/dio.dart';

class NetworkLoggerInterceptor extends InterceptorsWrapper {
  static const _logName = 'Dio';
  final JsonEncoder _jsonEncoder = const JsonEncoder.withIndent('  ');

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..writeln('➡️ [REQUEST] ${options.method} ${options.uri}')
      ..writeln('Headers: ${_prettyJson(options.headers)}');

    if (options.data != null) {
      buffer.writeln('Body: ${_prettyJson(options.data)}');
    }

    developer.log(buffer.toString(), name: _logName);
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..writeln(
        '✅ [RESPONSE] ${response.statusCode} ${response.requestOptions.uri}',
      )
      ..writeln('Headers: ${_prettyJson(response.headers.map)}');

    if (response.data != null) {
      buffer.writeln('Body: ${_prettyJson(response.data)}');
    }

    developer.log(buffer.toString(), name: _logName);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final buffer = StringBuffer()
      ..writeln(
        '❌ [ERROR] ${err.response?.statusCode} ${err.requestOptions.uri}',
      )
      ..writeln('Type: ${err.type}')
      ..writeln('Message: ${err.message}');

    if (err.response?.data != null) {
      buffer.writeln('Body: ${_prettyJson(err.response?.data)}');
    }

    developer.log(buffer.toString(), name: _logName, level: 1000);

    handler.next(_mapToAppException(err));
  }

  Object _prettyJson(Object? data) {
    try {
      if (data is Map || data is List) {
        return _jsonEncoder.convert(data);
      }
      return data ?? '<empty>';
    } catch (_) {
      return data?.toString() ?? '<empty>';
    }
  }

  DioException _mapToAppException(DioException error) {
    if (error.response?.statusCode == 401) {
      return DioException(
        requestOptions:
            error.response?.requestOptions ?? RequestOptions(path: ''),
        response: error.response,
        type: DioExceptionType.badCertificate,
        error: error,
      );
    }

    return error;
  }
}
