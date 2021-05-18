/// nurseid : 58
/// firstName : "Sadanand"
/// middleName : "M"
/// lastName : "Moris"
/// email : "sadanand.r@dashtechinc.com"
/// gender : "male"
/// role : "nurse"
/// address1 : "26 Harbor Road"
/// address2 : "5th floor"
/// phoneNumber : "977-979-7979"
/// displayAddress : "26 Harbor Park Drive, Port Washington, NY, USA"
/// zipCode : "97494"
/// dateOfBirth : "2021-03-11T00:00:00"
/// nurseImage : "http://35.231.45.54:70/AndroidNurseimg/scaled_c4c8c178-d57e-461d-80c8-1074fc932049228747073324945682720210413165725924.jpg"
/// cityName : "Port Washington"
/// stateName : "New York"
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
  String _displayAddress;
  String _zipCode;
  String _dateOfBirth;
  String _nurseImage;
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
  String get displayAddress => _displayAddress;
  String get zipCode => _zipCode;
  String get dateOfBirth => _dateOfBirth;
  String get nurseImage => _nurseImage;
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
      String displayAddress, 
      String zipCode, 
      String dateOfBirth, 
      String nurseImage, 
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
    _displayAddress = displayAddress;
    _zipCode = zipCode;
    _dateOfBirth = dateOfBirth;
    _nurseImage = nurseImage;
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
    _displayAddress = json["displayAddress"];
    _zipCode = json["zipCode"];
    _dateOfBirth = json["dateOfBirth"];
    _nurseImage = json["nurseImage"];
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
    map["displayAddress"] = _displayAddress;
    map["zipCode"] = _zipCode;
    map["dateOfBirth"] = _dateOfBirth;
    map["nurseImage"] = _nurseImage;
    map["cityName"] = _cityName;
    map["stateName"] = _stateName;
    map["isFirstTimeLogin"] = _isFirstTimeLogin;
    return map;
  }

}