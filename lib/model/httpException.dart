import 'package:setthi/config/string.dart';

class HttpException implements Exception {
  final String message;
  HttpException(this.message);

  String toString() {
    return message;
  }

  bool get isInternetProblem {
    return message == internetException;
  }
}
