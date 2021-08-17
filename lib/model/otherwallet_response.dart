// @dart=2.9
class OtherWalletResponse {
  bool success;
  String status;
  OtherData map;

  OtherWalletResponse({this.success, this.status, this.map});

  OtherWalletResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    map = json['map'] != null ? new OtherData.fromJson(json['map']) : null;
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

class OtherData {
  String address;
  String status;

  OtherData({this.address, this.status});

  OtherData.fromJson(Map<String, dynamic> json) {
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