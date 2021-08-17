// @dart=2.9
class ValidateCodeRequest {
  int code;
  String email;
  String password;
  String ipAddress;

  ValidateCodeRequest({this.code, this.email, this.password, this.ipAddress});

  ValidateCodeRequest.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    email = json['email'];
    password = json['password'];
    ipAddress = json['ipAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['email'] = this.email;
    data['password'] = this.password;
    data['ipAddress'] = this.ipAddress;
    return data;
  }
}