// @dart=2.9
class GetUserWalletAddressResponse {
  bool success;
  String status;
  Data map;

  GetUserWalletAddressResponse({this.success, this.status, this.map});

  GetUserWalletAddressResponse.fromJson(Map<String, dynamic> json) {
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
  String address;
  String status;

  Data({this.address, this.status});

  Data.fromJson(Map<String, dynamic> json) {
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