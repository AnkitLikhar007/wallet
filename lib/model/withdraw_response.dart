// @dart=2.9
class WithdrawResponse {
  bool success;
  String status;
  WithdrawData map;

  WithdrawResponse({this.success, this.status, this.map});

  WithdrawResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    map = json['map'] != null ? new WithdrawData.fromJson(json['map']) : null;
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

class WithdrawData {
  String address;
  String status;

  WithdrawData({this.address, this.status});

  WithdrawData.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['status'] = this.status;
    return data;
  }
}