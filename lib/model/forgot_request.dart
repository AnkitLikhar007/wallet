// @dart=2.9
class ForgotRequest {
  String email;
  String otp;
  String password;

  ForgotRequest({this.email, this.otp, this.password});

  ForgotRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['otp'] = this.otp;
    data['password'] = this.password;
    return data;
  }
}