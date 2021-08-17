// @dart=2.9

class ValidateCodeResponse {
  bool success;
  String status;
  ValidateData map;

  ValidateCodeResponse({this.success, this.status, this.map});

  ValidateCodeResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    map = json['map'] != null ? new ValidateData.fromJson(json['map']) : null;
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

class ValidateData {
  Null image;
  String name;
  String accesstoken;
  String userId;
  String email;
  String status;

  ValidateData(
      {this.image,
        this.name,
        this.accesstoken,
        this.userId,
        this.email,
        this.status});

  ValidateData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    accesstoken = json['accesstoken'];
    userId = json['userId'];
    email = json['email'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['accesstoken'] = this.accesstoken;
    data['userId'] = this.userId;
    data['email'] = this.email;
    data['status'] = this.status;
    return data;
  }
}

