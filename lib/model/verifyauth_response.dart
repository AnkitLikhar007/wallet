// @dart=2.9
class VerifyAuthCodeResponse {
  bool success;
  String status;
  DataVerify map;

  VerifyAuthCodeResponse({this.success, this.status, this.map});

  VerifyAuthCodeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    map = json['map'] != null ? new DataVerify.fromJson(json['map']) : null;
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

class DataVerify {
  bool verified;
  String status;

  DataVerify({this.verified, this.status});

  DataVerify.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['status'] = this.status;
    return data;
  }
}