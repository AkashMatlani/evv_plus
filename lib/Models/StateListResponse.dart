class StateListResponseModel {
  String status;
  String message;
  List<StateData> data;

  StateListResponseModel({this.status, this.message, this.data});

  StateListResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<StateData>();
      json['data'].forEach((v) {
        data.add(new StateData.fromJson(v));
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

class StateData {
  int stateId;
  String stateName;
  String stateCode;

  StateData({this.stateId, this.stateName, this.stateCode});

  StateData.fromJson(Map<String, dynamic> json) {
    stateId = json['stateId'];
    stateName = json['stateName'];
    stateCode = json['stateCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['stateCode'] = this.stateCode;
    return data;
  }
}