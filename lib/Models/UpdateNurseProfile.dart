class UpdateNurseProfile {
  String status;
  String message;
  Data data;

  UpdateNurseProfile({this.status, this.message, this.data});

  UpdateNurseProfile.fromJson(Map<String, dynamic> json) {
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
  String role;
  String address1;
  String address2;
  String phoneNumber;
  String email;
  String password;
  int fkcityId;
  int fkstateId;
  String zipCode;
  String dateOfBirth;
  String nurseImage;
  String fkcreatedBy;
  String createDate;
  Null fkmodifiedBy;
  String modifiedDate;
  bool isActive;
  bool isDeleted;
  String staffOtherNo;
  Null nurseGuid;
  String sequenceNo;
  String staffNo;
  String staffSsnno;
  bool isFirtsTimeLogin;
  List<Null> tblPatients;

  Data(
      {this.nurseid,
        this.firstName,
        this.middleName,
        this.lastName,
        this.gender,
        this.role,
        this.address1,
        this.address2,
        this.phoneNumber,
        this.email,
        this.password,
        this.fkcityId,
        this.fkstateId,
        this.zipCode,
        this.dateOfBirth,
        this.nurseImage,
        this.fkcreatedBy,
        this.createDate,
        this.fkmodifiedBy,
        this.modifiedDate,
        this.isActive,
        this.isDeleted,
        this.staffOtherNo,
        this.nurseGuid,
        this.sequenceNo,
        this.staffNo,
        this.staffSsnno,
        this.isFirtsTimeLogin,
        this.tblPatients});

  Data.fromJson(Map<String, dynamic> json) {
    nurseid = json['nurseid'];
    firstName = json['firstName'];
    middleName = json['middleName'];
    lastName = json['lastName'];
    gender = json['gender'];
    role = json['role'];
    address1 = json['address1'];
    address2 = json['address2'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    password = json['password'];
    fkcityId = json['fkcityId'];
    fkstateId = json['fkstateId'];
    zipCode = json['zipCode'];
    dateOfBirth = json['dateOfBirth'];
    nurseImage = json['nurseImage'];
    fkcreatedBy = json['fkcreatedBy'];
    createDate = json['createDate'];
    fkmodifiedBy = json['fkmodifiedBy'];
    modifiedDate = json['modifiedDate'];
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    staffOtherNo = json['staffOtherNo'];
    nurseGuid = json['nurseGuid'];
    sequenceNo = json['sequenceNo'];
    staffNo = json['staffNo'];
    staffSsnno = json['staffSsnno'];
    isFirtsTimeLogin = json['isFirtsTimeLogin'];
    if (json['tblPatients'] != null) {
      tblPatients = [];
      /*json['tblPatients'].forEach((v) {
        tblPatients.add(new Null.fromJson(v));
      });*/
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nurseid'] = this.nurseid;
    data['firstName'] = this.firstName;
    data['middleName'] = this.middleName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['role'] = this.role;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['fkcityId'] = this.fkcityId;
    data['fkstateId'] = this.fkstateId;
    data['zipCode'] = this.zipCode;
    data['dateOfBirth'] = this.dateOfBirth;
    data['nurseImage'] = this.nurseImage;
    data['fkcreatedBy'] = this.fkcreatedBy;
    data['createDate'] = this.createDate;
    data['fkmodifiedBy'] = this.fkmodifiedBy;
    data['modifiedDate'] = this.modifiedDate;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['staffOtherNo'] = this.staffOtherNo;
    data['nurseGuid'] = this.nurseGuid;
    data['sequenceNo'] = this.sequenceNo;
    data['staffNo'] = this.staffNo;
    data['staffSsnno'] = this.staffSsnno;
    data['isFirtsTimeLogin'] = this.isFirtsTimeLogin;
    /*if (this.tblPatients != null) {
      data['tblPatients'] = this.tblPatients.map((v) => v.toJson()).toList();
    }*/

    return data;
  }
}