// @dart=2.9
class ForgotResponse {
  bool success;
  String status;
  Data map;

  ForgotResponse({this.success, this.status, this.map});

  ForgotResponse.fromJson(Map<String, dynamic> json) {
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
  String status;

  Data({this.status});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}