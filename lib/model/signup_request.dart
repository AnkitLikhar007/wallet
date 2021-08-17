// @dart=2.9
class SignUpRequest {
  String name;
  String email;
  String password;
  String walletAddress;

  SignUpRequest({this.name, this.email, this.password, this.walletAddress});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    walletAddress = json['walletAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['walletAddress'] = this.walletAddress;
    return data;
  }
}