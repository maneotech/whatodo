import 'dart:convert';

class AdVideoModel {
  Uri urlSrc;
  String redirectTo;

  AdVideoModel(this.urlSrc, this.redirectTo);

  factory AdVideoModel.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return AdVideoModel(
      Uri.parse(json['urlSrc']),
      json['redirectTo'],
    );
  }
}
