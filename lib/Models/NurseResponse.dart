/// nurseid : 7
/// firstName : "Sadananad"
/// middleName : "rrrr"
/// lastName : "Moris"
/// email : "sadanand.r@dashtechinc.com"
/// gender : "Male"
/// role : "nurse"
/// address1 : "36 West 5th Street"
/// address2 : "10th Floor"
/// phoneNumber : "1234567895"
/// zipCode : "10019"
/// dateOfBirth : "1991-12-22T00:00:00"
/// nurseImage : ""
/// cityId : 1
/// stateId : 1
/// cityName : "Moody\r\n"
/// stateName : "Alabama"
/// isFirstTimeLogin : true

class NurseResponse {
  int _nurseid;
  String _firstName;
  String _middleName;
  String _lastName;
  String _email;
  String _gender;
  String _role;
  String _address1;
  String _address2;
  String _phoneNumber;
  String _zipCode;
  String _dateOfBirth;
  String _nurseImage;
  int _cityId;
  int _stateId;
  String _cityName;
  String _stateName;
  bool _isFirstTimeLogin;

  int get nurseid => _nurseid;
  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
  String get email => _email;
  String get gender => _gender;
  String get role => _role;
  String get address1 => _address1;
  String get address2 => _address2;
  String get phoneNumber => _phoneNumber;
  String get zipCode => _zipCode;
  String get dateOfBirth => _dateOfBirth;
  String get nurseImage => _nurseImage;
  int get cityId => _cityId;
  int get stateId => _stateId;
  String get cityName => _cityName;
  String get stateName => _stateName;
  bool get isFirstTimeLogin => _isFirstTimeLogin;

  NurseResponse({
      int nurseid, 
      String firstName, 
      String middleName, 
      String lastName, 
      String email, 
      String gender, 
      String role, 
      String address1, 
      String address2, 
      String phoneNumber, 
      String zipCode, 
      String dateOfBirth, 
      String nurseImage, 
      int cityId, 
      int stateId, 
      String cityName, 
      String stateName, 
      bool isFirstTimeLogin}){
    _nurseid = nurseid;
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _email = email;
    _gender = gender;
    _role = role;
    _address1 = address1;
    _address2 = address2;
    _phoneNumber = phoneNumber;
    _zipCode = zipCode;
    _dateOfBirth = dateOfBirth;
    _nurseImage = nurseImage;
    _cityId = cityId;
    _stateId = stateId;
    _cityName = cityName;
    _stateName = stateName;
    _isFirstTimeLogin = isFirstTimeLogin;
}

  NurseResponse.fromJson(dynamic json) {
    _nurseid = json["nurseid"];
    _firstName = json["firstName"];
    _middleName = json["middleName"];
    _lastName = json["lastName"];
    _email = json["email"];
    _gender = json["gender"];
    _role = json["role"];
    _address1 = json["address1"];
    _address2 = json["address2"];
    _phoneNumber = json["phoneNumber"];
    _zipCode = json["zipCode"];
    _dateOfBirth = json["dateOfBirth"];
    _nurseImage = json["nurseImage"];
    _cityId = json["cityId"];
    _stateId = json["stateId"];
    _cityName = json["cityName"];
    _stateName = json["stateName"];
    _isFirstTimeLogin = json["isFirstTimeLogin"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["nurseid"] = _nurseid;
    map["firstName"] = _firstName;
    map["middleName"] = _middleName;
    map["lastName"] = _lastName;
    map["email"] = _email;
    map["gender"] = _gender;
    map["role"] = _role;
    map["address1"] = _address1;
    map["address2"] = _address2;
    map["phoneNumber"] = _phoneNumber;
    map["zipCode"] = _zipCode;
    map["dateOfBirth"] = _dateOfBirth;
    map["nurseImage"] = _nurseImage;
    map["cityId"] = _cityId;
    map["stateId"] = _stateId;
    map["cityName"] = _cityName;
    map["stateName"] = _stateName;
    map["isFirstTimeLogin"] = _isFirstTimeLogin;
    return map;
  }

}