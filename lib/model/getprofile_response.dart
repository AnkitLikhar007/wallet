// @dart=2.9
class GetProfileResponse {
  bool success;
  String status;
  Data map;

  GetProfileResponse({this.success, this.status, this.map});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
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
  String wallet;
  bool googleAuth;
  String name;
  String email;
  String status;

  Data({this.wallet, this.googleAuth, this.name, this.email, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    googleAuth = json['googleAuth'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet'] = this.wallet;
    data['googleAuth'] = this.googleAuth;
    data['name'] = this.name;
    data['email'] = this.email;
    data['status'] = this.status;
    return data;
  }
}