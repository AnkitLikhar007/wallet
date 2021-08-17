// @dart=2.9
class AuthQrResponse {
  bool success;
  String status;
  Data map;

  AuthQrResponse({this.success, this.status, this.map});

  AuthQrResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    map = json['map'] != null ? new Data.fromJson(json['map']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.map != null) {
      data['map'] = this.map.toJson();
    }
    return data;
  }
}

class Data {
  String secretKey;
  bool verified;
  String url;
  String status;

  Data({this.secretKey, this.verified, this.url, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    secretKey = json['secretKey'];
    verified = json['verified'];
    url = json['url'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secretKey'] = this.secretKey;
    data['verified'] = this.verified;
    data['url'] = this.url;
    data['status'] = this.status;
    return data;
  }
}