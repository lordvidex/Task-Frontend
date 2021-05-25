import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TaskException implements Exception {
  final String message;
  final int? statusCode;
  final String? error;
  TaskException(this.message, {this.statusCode, this.error});
  @override
  String toString() {
    String x = message;
    if (error != null) {
      x = '$error, $x';
    }
    if (statusCode != null) {
      x = '$statusCode $x';
    }
    return x;
  }
}

extension DioErrorExtended on DioError {
  // adds the response error message from the backend if it is available
  // else it returns the default unclear/user unfriendly dio error message
  String errorMessage() {
    String? backEndErrorMessage = _resolveErrorMessage();
    if (backEndErrorMessage != null) {
      return backEndErrorMessage;
    }
    return this.message;
  }

  String? _resolveErrorMessage() {
    var message = this.response?.data['message'];
    if (message is List) {
      message = message.join(", ");
    }
    return message.toString();
  }
}
