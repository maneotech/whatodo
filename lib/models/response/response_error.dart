import 'dart:convert';

class ResponseError {
  final int error;
  final String message;
  final Object? data;

  ResponseError(this.error, this.message, this.data);

  factory ResponseError.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return ResponseError(
      json['error'],
      json['message'],
      json['data'],
    );
  }
}
