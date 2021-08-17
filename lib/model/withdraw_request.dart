// @dart=2.9
class WithdrawRequest {
  String address;
  num amount;

  WithdrawRequest({this.address, this.amount});

  WithdrawRequest.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['amount'] = this.amount;
    return data;
  }
}