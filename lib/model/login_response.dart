// @dart=2.9
class LoginResponse {
  bool success;
  String status;
  Data map;

  LoginResponse({this.success, this.status, this.map});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  String name;
  String accesstoken;
  String userId;
  String email;
  String status;

  Data({this.name, this.accesstoken, this.userId, this.email, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    accesstoken = json['accesstoken'];
    userId = json['userId'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['accesstoken'] = this.accesstoken;
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['status'] = this.status;
    return data;
  }
}