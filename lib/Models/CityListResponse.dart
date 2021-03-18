class CityListResponse {
  String status;
  String message;
  List<CityData> data;

  CityListResponse({this.status, this.message, this.data});

  CityListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<CityData>();
      json['data'].forEach((v) {
        data.add(new CityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityData {
  int cityId;
  int stateId;
  String cityName;

  CityData({this.cityId, this.stateId, this.cityName});

  CityData.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'];
    stateId = json['stateId'];
    cityName = json['cityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityId'] = this.cityId;
    data['stateId'] = this.stateId;
    data['cityName'] = this.cityName;
    return data;
  }
}