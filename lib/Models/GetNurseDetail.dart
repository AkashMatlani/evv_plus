class NurseDetail {
  String status;
  String message;
  Data data;

  NurseDetail({this.status, this.message, this.data});

  NurseDetail.fromJson(Map<String, dynamic> json) {
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
  int nurseid;
  String firstName;
  String middleName;
  String lastName;
  String gender;
  String address1;
  String address2;
  String phoneNumber;
  String email;
  int fkcityId;
  int fkstateId;
  String zipCode;
  String dateOfBirth;
  String nurseImage;

  Data(
  {this.nurseid,
  this.firstName,
  this.middleName,
  this.lastName,
  this.gender,
  this.address1,
  this.address2,
  this.phoneNumber,
  this.email,
  this.fkcityId,
  this.fkstateId,
  this.zipCode,
  this.dateOfBirth,
  this.nurseImage});

  Data.fromJson(Map<String, dynamic> json) {
  nurseid = json['nurseid'];
  firstName = json['firstName'];
  middleName = json['middleName'];
  lastName = json['lastName'];
  gender = json['gender'];
  address1 = json['address1'];
  address2 = json['address2'];
  phoneNumber = json['phoneNumber'];
  email = json['email'];
  fkcityId = json['fkcityId'];
  fkstateId = json['fkstateId'];
  zipCode = json['zipCode'];
  dateOfBirth = json['dateOfBirth'];
  nurseImage = json['nurseImage'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['nurseid'] = this.nurseid;
  data['firstName'] = this.firstName;
  data['middleName'] = this.middleName;
  data['lastName'] = this.lastName;
  data['gender'] = this.gender;
  data['address1'] = this.address1;
  data['address2'] = this.address2;
  data['phoneNumber'] = this.phoneNumber;
  data['email'] = this.email;
  data['fkcityId'] = this.fkcityId;
  data['fkstateId'] = this.fkstateId;
  data['zipCode'] = this.zipCode;
  data['dateOfBirth'] = this.dateOfBirth;
  data['nurseImage'] = this.nurseImage;
  return data;
  }
  }
