// @dart=2.9
class WithDrawRequestRequest {
  int size;
  int pageNumber;
  String keyword;
  String sortWay;
  String sortBy;

  WithDrawRequestRequest(
      {this.size, this.pageNumber, this.keyword, this.sortWay, this.sortBy});

  WithDrawRequestRequest.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    pageNumber = json['pageNumber'];
    keyword = json['keyword'];
    sortWay = json['sortWay'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['pageNumber'] = this.pageNumber;
    data['keyword'] = this.keyword;
    data['sortWay'] = this.sortWay;
    data['sortBy'] = this.sortBy;
    return data;
  }
}