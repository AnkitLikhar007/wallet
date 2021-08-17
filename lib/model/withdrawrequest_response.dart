// @dart=2.9
class WithDrawRequestResponse {
  bool success;
  String status;
  Data map;

  WithDrawRequestResponse({this.success, this.status, this.map});

  WithDrawRequestResponse.fromJson(Map<String, dynamic> json) {
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
  int size;
  List<Withdraws> withdraws;
  String status;

  Data({this.size, this.withdraws, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    if (json['withdraws'] != null) {
      withdraws = new List<Withdraws>();
      json['withdraws'].forEach((v) {
        withdraws.add(new Withdraws.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    if (this.withdraws != null) {
      data['withdraws'] = this.withdraws.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Withdraws {
  String date;
  double amount;
  String address;
  bool withComplete;
  int id;
  bool withCancelled;

  Withdraws(
      {this.date,
        this.amount,
        this.address,
        this.withComplete,
        this.id,
        this.withCancelled});

  Withdraws.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    amount = json['amount'];
    address = json['address'];
    withComplete = json['withComplete'];
    id = json['id'];
    withCancelled = json['withCancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['amount'] = this.amount;
    data['address'] = this.address;
    data['withComplete'] = this.withComplete;
    data['id'] = this.id;
    data['withCancelled'] = this.withCancelled;
    return data;
  }
}