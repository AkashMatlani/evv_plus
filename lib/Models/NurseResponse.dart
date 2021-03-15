
class NurseResponse {
  int _nurseid;
  String _firstName;
  String _middleName;
  String _lastName;
  String _gender;
  String _role;
  String _address1;
  String _address2;
  String _phoneNumber;
  String _email;
  String _password;
  int _fkcityId;
  int _fkstateId;
  String _zipCode;
  String _dateOfBirth;
  dynamic _nurseImage;
  String _fkcreatedBy;
  String _createDate;
  dynamic _fkmodifiedBy;
  String _modifiedDate;
  bool _isActive;
  bool _isDeleted;
  dynamic _nurseGuid;
  String _staffOtherNo;
  String _sequenceNo;
  String _staffNo;
  String _staffSSNNo;
  bool _isFirtsTimeLogin;
  List<dynamic> _tblPatients;

  int get nurseid => _nurseid;
  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
  String get gender => _gender;
  String get role => _role;
  String get address1 => _address1;
  String get address2 => _address2;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
  String get password => _password;
  int get fkcityId => _fkcityId;
  int get fkstateId => _fkstateId;
  String get zipCode => _zipCode;
  String get dateOfBirth => _dateOfBirth;
  dynamic get nurseImage => _nurseImage;
  String get fkcreatedBy => _fkcreatedBy;
  String get createDate => _createDate;
  dynamic get fkmodifiedBy => _fkmodifiedBy;
  String get modifiedDate => _modifiedDate;
  bool get isActive => _isActive;
  bool get isDeleted => _isDeleted;
  dynamic get nurseGuid => _nurseGuid;
  String get staffOtherNo => _staffOtherNo;
  String get sequenceNo => _sequenceNo;
  String get staffNo => _staffNo;
  String get staffSSNNo => _staffSSNNo;
  bool get isFirtsTimeLogin => _isFirtsTimeLogin;
  List<dynamic> get tblPatients => _tblPatients;

  NurseResponse({
      int nurseid, 
      String firstName, 
      String middleName, 
      String lastName, 
      String gender, 
      String role, 
      String address1, 
      String address2, 
      String phoneNumber, 
      String email, 
      String password, 
      int fkcityId, 
      int fkstateId, 
      String zipCode, 
      String dateOfBirth, 
      dynamic nurseImage, 
      String fkcreatedBy, 
      String createDate, 
      dynamic fkmodifiedBy, 
      String modifiedDate, 
      bool isActive, 
      bool isDeleted, 
      dynamic nurseGuid, 
      String staffOtherNo, 
      String sequenceNo, 
      String staffNo, 
      String staffSSNNo, 
      bool isFirtsTimeLogin, 
      List<dynamic> tblPatients}){
    _nurseid = nurseid;
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _gender = gender;
    _role = role;
    _address1 = address1;
    _address2 = address2;
    _phoneNumber = phoneNumber;
    _email = email;
    _password = password;
    _fkcityId = fkcityId;
    _fkstateId = fkstateId;
    _zipCode = zipCode;
    _dateOfBirth = dateOfBirth;
    _nurseImage = nurseImage;
    _fkcreatedBy = fkcreatedBy;
    _createDate = createDate;
    _fkmodifiedBy = fkmodifiedBy;
    _modifiedDate = modifiedDate;
    _isActive = isActive;
    _isDeleted = isDeleted;
    _nurseGuid = nurseGuid;
    _staffOtherNo = staffOtherNo;
    _sequenceNo = sequenceNo;
    _staffNo = staffNo;
    _staffSSNNo = staffSSNNo;
    _isFirtsTimeLogin = isFirtsTimeLogin;
    _tblPatients = tblPatients;
}

  NurseResponse.fromJson(dynamic json) {
    _nurseid = json["nurseid"];
    _firstName = json["firstName"];
    _middleName = json["middleName"];
    _lastName = json["lastName"];
    _gender = json["gender"];
    _role = json["role"];
    _address1 = json["address1"];
    _address2 = json["address2"];
    _phoneNumber = json["phoneNumber"];
    _email = json["email"];
    _password = json["password"];
    _fkcityId = json["fkcityId"];
    _fkstateId = json["fkstateId"];
    _zipCode = json["zipCode"];
    _dateOfBirth = json["dateOfBirth"];
    _nurseImage = json["nurseImage"];
    _fkcreatedBy = json["fkcreatedBy"];
    _createDate = json["createDate"];
    _fkmodifiedBy = json["fkmodifiedBy"];
    _modifiedDate = json["modifiedDate"];
    _isActive = json["isActive"];
    _isDeleted = json["isDeleted"];
    _nurseGuid = json["nurseGuid"];
    _staffOtherNo = json["staffOtherNo"];
    _sequenceNo = json["sequenceNo"];
    _staffNo = json["staffNo"];
    _staffSSNNo = json["staffSSNNo"];
    _isFirtsTimeLogin = json["isFirtsTimeLogin"];
    if (json["tblPatients"] != null) {
      _tblPatients = [];
      /*json["tblPatients"].forEach((v) {
        _tblPatients.add(dynamic.fromJson(v));
      });*/
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["nurseid"] = _nurseid;
    map["firstName"] = _firstName;
    map["middleName"] = _middleName;
    map["lastName"] = _lastName;
    map["gender"] = _gender;
    map["role"] = _role;
    map["address1"] = _address1;
    map["address2"] = _address2;
    map["phoneNumber"] = _phoneNumber;
    map["email"] = _email;
    map["password"] = _password;
    map["fkcityId"] = _fkcityId;
    map["fkstateId"] = _fkstateId;
    map["zipCode"] = _zipCode;
    map["dateOfBirth"] = _dateOfBirth;
    map["nurseImage"] = _nurseImage;
    map["fkcreatedBy"] = _fkcreatedBy;
    map["createDate"] = _createDate;
    map["fkmodifiedBy"] = _fkmodifiedBy;
    map["modifiedDate"] = _modifiedDate;
    map["isActive"] = _isActive;
    map["isDeleted"] = _isDeleted;
    map["nurseGuid"] = _nurseGuid;
    map["staffOtherNo"] = _staffOtherNo;
    map["sequenceNo"] = _sequenceNo;
    map["staffNo"] = _staffNo;
    map["staffSSNNo"] = _staffSSNNo;
    map["isFirtsTimeLogin"] = _isFirtsTimeLogin;
    if (_tblPatients != null) {
      map["tblPatients"] = _tblPatients.map((v) => v.toJson()).toList();
    }
    return map;
  }

}