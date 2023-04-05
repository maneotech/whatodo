import 'dart:convert';

class AdVideoDocument {
  String id;
  AdVideoModel adContent;

  AdVideoDocument(this.id, this.adContent);

  factory AdVideoDocument.fromReqBody(String body) {
    Map<String, dynamic> json = jsonDecode(body);

    return AdVideoDocument(
      json['_id'],
      AdVideoModel.fromReqBody(jsonEncode(json['adContent'])),
    );
  }
}

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
