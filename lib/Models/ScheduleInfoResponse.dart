/// patientId : 16
/// profilePhotoPath : "http://35.231.45.54:70/AndroidNurseimg/"
/// displayAddress : "36 5th Ave, New York, NY 10011, USA"
/// latitude : 40.73375000
/// longitude : -73.99569000
/// staffId : 1
/// firstName : "kriti"
/// middleName : "L"
/// lastName : "Jacob"
/// phoneNumber : "9865465465"
/// addressLine1 : "36 5th Avenue"
/// addressLine2 : "10th floor"
/// zipcode : "38000"
/// visitId : 1111
/// visitDate : "2021-05-22T00:00:00"
/// timeFrom : "11:00:00"
/// timeTo : "12:00:00"
/// birthdate : "1998-02-04T18:30:00"
/// isActive : true
/// isDelete : false
/// createdDate : "2021-05-07T17:28:20.943"
/// modifiedDate : "2021-05-07T17:28:20.943"
/// createdBy : null
/// modifiedBy : null
/// carePlanName : "PLN"
/// isVisited : false
/// cityName : "New York"
/// stateName : "New York"
/// checkInTime : "00:00:00"
/// checkOutTime : "00:00:00"

class ScheduleInfoResponse {
  int _patientId;
  String _profilePhotoPath;
  String _displayAddress;
  double _latitude;
  double _longitude;
  int _staffId;
  String _firstName;
  String _middleName;
  String _lastName;
  String _phoneNumber;
  String _addressLine1;
  String _addressLine2;
  String _zipcode;
  int _visitId;
  String _visitDate;
  String _timeFrom;
  String _timeTo;
  String _birthdate;
  bool _isActive;
  bool _isDelete;
  String _createdDate;
  String _modifiedDate;
  dynamic _createdBy;
  dynamic _modifiedBy;
  String _carePlanName;
  bool _isVisited;
  String _cityName;
  String _stateName;
  String _checkInTime;
  String _checkOutTime;

  int get patientId => _patientId;
  String get profilePhotoPath => _profilePhotoPath;
  String get displayAddress => _displayAddress;
  double get latitude => _latitude;
  double get longitude => _longitude;
  int get staffId => _staffId;
  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
  String get phoneNumber => _phoneNumber;
  String get addressLine1 => _addressLine1;
  String get addressLine2 => _addressLine2;
  String get zipcode => _zipcode;
  int get visitId => _visitId;
  String get visitDate => _visitDate;
  String get timeFrom => _timeFrom;
  String get timeTo => _timeTo;
  String get birthdate => _birthdate;
  bool get isActive => _isActive;
  bool get isDelete => _isDelete;
  String get createdDate => _createdDate;
  String get modifiedDate => _modifiedDate;
  dynamic get createdBy => _createdBy;
  dynamic get modifiedBy => _modifiedBy;
  String get carePlanName => _carePlanName;
  bool get isVisited => _isVisited;
  String get cityName => _cityName;
  String get stateName => _stateName;
  String get checkInTime => _checkInTime;
  String get checkOutTime => _checkOutTime;

  ScheduleInfoResponse({
      int patientId, 
      String profilePhotoPath, 
      String displayAddress, 
      double latitude, 
      double longitude, 
      int staffId, 
      String firstName, 
      String middleName, 
      String lastName, 
      String phoneNumber, 
      String addressLine1, 
      String addressLine2, 
      String zipcode, 
      int visitId, 
      String visitDate, 
      String timeFrom, 
      String timeTo, 
      String birthdate, 
      bool isActive, 
      bool isDelete, 
      String createdDate, 
      String modifiedDate, 
      dynamic createdBy, 
      dynamic modifiedBy, 
      String carePlanName, 
      bool isVisited, 
      String cityName, 
      String stateName, 
      String checkInTime, 
      String checkOutTime}){
    _patientId = patientId;
    _profilePhotoPath = profilePhotoPath;
    _displayAddress = displayAddress;
    _latitude = latitude;
    _longitude = longitude;
    _staffId = staffId;
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _zipcode = zipcode;
    _visitId = visitId;
    _visitDate = visitDate;
    _timeFrom = timeFrom;
    _timeTo = timeTo;
    _birthdate = birthdate;
    _isActive = isActive;
    _isDelete = isDelete;
    _createdDate = createdDate;
    _modifiedDate = modifiedDate;
    _createdBy = createdBy;
    _modifiedBy = modifiedBy;
    _carePlanName = carePlanName;
    _isVisited = isVisited;
    _cityName = cityName;
    _stateName = stateName;
    _checkInTime = checkInTime;
    _checkOutTime = checkOutTime;
}

  ScheduleInfoResponse.fromJson(dynamic json) {
    _patientId = json["patientId"];
    _profilePhotoPath = json["profilePhotoPath"];
    _displayAddress = json["displayAddress"];
    _latitude = json["latitude"];
    _longitude = json["longitude"];
    _staffId = json["staffId"];
    _firstName = json["firstName"];
    _middleName = json["middleName"];
    _lastName = json["lastName"];
    _phoneNumber = json["phoneNumber"];
    _addressLine1 = json["addressLine1"];
    _addressLine2 = json["addressLine2"];
    _zipcode = json["zipcode"];
    _visitId = json["visitId"];
    _visitDate = json["visitDate"];
    _timeFrom = json["timeFrom"];
    _timeTo = json["timeTo"];
    _birthdate = json["birthdate"];
    _isActive = json["isActive"];
    _isDelete = json["isDelete"];
    _createdDate = json["createdDate"];
    _modifiedDate = json["modifiedDate"];
    _createdBy = json["createdBy"];
    _modifiedBy = json["modifiedBy"];
    _carePlanName = json["carePlanName"];
    _isVisited = json["isVisited"];
    _cityName = json["cityName"];
    _stateName = json["stateName"];
    _checkInTime = json["checkInTime"];
    _checkOutTime = json["checkOutTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["patientId"] = _patientId;
    map["profilePhotoPath"] = _profilePhotoPath;
    map["displayAddress"] = _displayAddress;
    map["latitude"] = _latitude;
    map["longitude"] = _longitude;
    map["staffId"] = _staffId;
    map["firstName"] = _firstName;
    map["middleName"] = _middleName;
    map["lastName"] = _lastName;
    map["phoneNumber"] = _phoneNumber;
    map["addressLine1"] = _addressLine1;
    map["addressLine2"] = _addressLine2;
    map["zipcode"] = _zipcode;
    map["visitId"] = _visitId;
    map["visitDate"] = _visitDate;
    map["timeFrom"] = _timeFrom;
    map["timeTo"] = _timeTo;
    map["birthdate"] = _birthdate;
    map["isActive"] = _isActive;
    map["isDelete"] = _isDelete;
    map["createdDate"] = _createdDate;
    map["modifiedDate"] = _modifiedDate;
    map["createdBy"] = _createdBy;
    map["modifiedBy"] = _modifiedBy;
    map["carePlanName"] = _carePlanName;
    map["isVisited"] = _isVisited;
    map["cityName"] = _cityName;
    map["stateName"] = _stateName;
    map["checkInTime"] = _checkInTime;
    map["checkOutTime"] = _checkOutTime;
    return map;
  }

}