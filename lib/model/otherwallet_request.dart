// @dart=2.9
class OtherWalletRequest {
  String address;

  OtherWalletRequest({this.address});

  OtherWalletRequest.fromJson(Map<String, dynamic> json) {
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    return data;
  }
}