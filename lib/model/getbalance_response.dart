// @dart=2.9
class GetBalanceResponse {
  bool success;
  String status;
  Data map;

  GetBalanceResponse({this.success, this.status, this.map});

  GetBalanceResponse.fromJson(Map<String, dynamic> json) {
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
  num amount;
  String status;

  Data({this.amount, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['status'] = this.status;
    return data;
  }
}