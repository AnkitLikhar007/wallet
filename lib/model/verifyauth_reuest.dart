// @dart=2.9
class VerifyAuthCodeRequest {
  String secretKey;
  int otp;

  VerifyAuthCodeRequest({this.secretKey, this.otp});

  VerifyAuthCodeRequest.fromJson(Map<String, dynamic> json) {
    secretKey = json['secretKey'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['secretKey'] = this.secretKey;
    data['otp'] = this.otp;
    return data;
  }
}