// @dart=2.9
class GetTransactionResponse {
  bool success;
  String status;
  TransactionData map;

  GetTransactionResponse({this.success, this.status, this.map});

  GetTransactionResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    map = json['map'] != null ? new TransactionData.fromJson(json['map']) : null;
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

class TransactionData {
  num amount;
  int records;
  List<Transactions> transactions;
  String status;

  TransactionData({this.amount, this.records, this.transactions, this.status});

  TransactionData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    records = json['records'];
    if (json['transactions'] != null) {
      transactions = new List<Transactions>();
      json['transactions'].forEach((v) {
        transactions.add(new Transactions.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['records'] = this.records;
    if (this.transactions != null) {
      data['transactions'] = this.transactions.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Transactions {
  double amount;
  String receiver;
  String sender;
  String creationDate;

  Transactions({this.amount, this.receiver, this.sender, this.creationDate});

  Transactions.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    receiver = json['receiver'];
    sender = json['sender'];
    creationDate = json['creationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['receiver'] = this.receiver;
    data['sender'] = this.sender;
    data['creationDate'] = this.creationDate;
    return data;
  }
}