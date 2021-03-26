class VisitCompleteModel {
  String status;
  String message;
  Data data;

  VisitCompleteModel({this.status, this.message, this.data});

  VisitCompleteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String patientName;
  String nurseName;
  String checkInDate;
  String checkInTime;
  Null checkOutDate;
  String checkOutTime;

  Data(
      {this.patientName,
        this.nurseName,
        this.checkInDate,
        this.checkInTime,
        this.checkOutDate,
        this.checkOutTime});

  Data.fromJson(Map<String, dynamic> json) {
    patientName = json['PatientName'];
    nurseName = json['NurseName'];
    checkInDate = json['CheckInDate'];
    checkInTime = json['CheckInTime'];
    checkOutDate = json['CheckOutDate'];
    checkOutTime = json['CheckOutTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PatientName'] = this.patientName;
    data['NurseName'] = this.nurseName;
    data['CheckInDate'] = this.checkInDate;
    data['CheckInTime'] = this.checkInTime;
    data['CheckOutDate'] = this.checkOutDate;
    data['CheckOutTime'] = this.checkOutTime;
    return data;
  }
}

