// @dart=2.9
class SendCoinRequest {
  String receiver;
  String amount;

  SendCoinRequest({this.receiver, this.amount});

  SendCoinRequest.fromJson(Map<String, dynamic> json) {
    receiver = json['receiver'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receiver'] = this.receiver;
    data['amount'] = this.amount;
    return data;
  }
}