/// patientId : 2
/// staffId : 1
/// firstName : "test"
/// middleName : "b"
/// lastName : "test"
/// phoneNumber : null
/// addressLine1 : "36 West 5th Street"
/// addressLine2 : "10th Floor"
/// zipcode : "10017"
/// visitDate : "2021-03-15T12:00:00"
/// timeFrom : "11:00:00"
/// timeTo : "12:30:00"
/// isActive : true
/// isDelete : false
/// createdDate : "2021-03-15T00:00:00"
/// modifiedDate : "2021-03-15T00:00:00"
/// createdBy : 1
/// modifiedBy : null
/// carePlanName : "care1"
/// isVisited : false
/// latitude : 40.74310320
/// longitude : -73.42287410
/// cityname : "Manhattan"
/// state : "NY"

class ScheduleInfoResponse {
  int _patientId;
  int _staffId;
  String _firstName;
  String _middleName;
  String _lastName;
  dynamic _phoneNumber;
  String _addressLine1;
  String _addressLine2;
  String _zipcode;
  String _visitDate;
  String _timeFrom;
  String _timeTo;
  bool _isActive;
  bool _isDelete;
  String _createdDate;
  String _modifiedDate;
  int _createdBy;
  dynamic _modifiedBy;
  String _carePlanName;
  bool _isVisited;
  double _latitude;
  double _longitude;
  String _cityname;
  String _state;

  int get patientId => _patientId;
  int get staffId => _staffId;
  String get firstName => _firstName;
  String get middleName => _middleName;
  String get lastName => _lastName;
  dynamic get phoneNumber => _phoneNumber;
  String get addressLine1 => _addressLine1;
  String get addressLine2 => _addressLine2;
  String get zipcode => _zipcode;
  String get visitDate => _visitDate;
  String get timeFrom => _timeFrom;
  String get timeTo => _timeTo;
  bool get isActive => _isActive;
  bool get isDelete => _isDelete;
  String get createdDate => _createdDate;
  String get modifiedDate => _modifiedDate;
  int get createdBy => _createdBy;
  dynamic get modifiedBy => _modifiedBy;
  String get carePlanName => _carePlanName;
  bool get isVisited => _isVisited;
  double get latitude => _latitude;
  double get longitude => _longitude;
  String get cityname => _cityname;
  String get state => _state;

  ScheduleInfoResponse({
      int patientId, 
      int staffId, 
      String firstName, 
      String middleName, 
      String lastName, 
      dynamic phoneNumber, 
      String addressLine1, 
      String addressLine2, 
      String zipcode, 
      String visitDate, 
      String timeFrom, 
      String timeTo, 
      bool isActive, 
      bool isDelete, 
      String createdDate, 
      String modifiedDate, 
      int createdBy, 
      dynamic modifiedBy, 
      String carePlanName, 
      bool isVisited, 
      double latitude, 
      double longitude, 
      String cityname, 
      String state}){
    _patientId = patientId;
    _staffId = staffId;
    _firstName = firstName;
    _middleName = middleName;
    _lastName = lastName;
    _phoneNumber = phoneNumber;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _zipcode = zipcode;
    _visitDate = visitDate;
    _timeFrom = timeFrom;
    _timeTo = timeTo;
    _isActive = isActive;
    _isDelete = isDelete;
    _createdDate = createdDate;
    _modifiedDate = modifiedDate;
    _createdBy = createdBy;
    _modifiedBy = modifiedBy;
    _carePlanName = carePlanName;
    _isVisited = isVisited;
    _latitude = latitude;
    _longitude = longitude;
    _cityname = cityname;
    _state = state;
}

  ScheduleInfoResponse.fromJson(dynamic json) {
    _patientId = json["patientId"];
    _staffId = json["staffId"];
    _firstName = json["firstName"];
    _middleName = json["middleName"];
    _lastName = json["lastName"];
    _phoneNumber = json["phoneNumber"];
    _addressLine1 = json["addressLine1"];
    _addressLine2 = json["addressLine2"];
    _zipcode = json["zipcode"];
    _visitDate = json["visitDate"];
    _timeFrom = json["timeFrom"];
    _timeTo = json["timeTo"];
    _isActive = json["isActive"];
    _isDelete = json["isDelete"];
    _createdDate = json["createdDate"];
    _modifiedDate = json["modifiedDate"];
    _createdBy = json["createdBy"];
    _modifiedBy = json["modifiedBy"];
    _carePlanName = json["carePlanName"];
    _isVisited = json["isVisited"];
    _latitude = json["latitude"];
    _longitude = json["longitude"];
    _cityname = json["cityname"];
    _state = json["state"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["patientId"] = _patientId;
    map["staffId"] = _staffId;
    map["firstName"] = _firstName;
    map["middleName"] = _middleName;
    map["lastName"] = _lastName;
    map["phoneNumber"] = _phoneNumber;
    map["addressLine1"] = _addressLine1;
    map["addressLine2"] = _addressLine2;
    map["zipcode"] = _zipcode;
    map["visitDate"] = _visitDate;
    map["timeFrom"] = _timeFrom;
    map["timeTo"] = _timeTo;
    map["isActive"] = _isActive;
    map["isDelete"] = _isDelete;
    map["createdDate"] = _createdDate;
    map["modifiedDate"] = _modifiedDate;
    map["createdBy"] = _createdBy;
    map["modifiedBy"] = _modifiedBy;
    map["carePlanName"] = _carePlanName;
    map["isVisited"] = _isVisited;
    map["latitude"] = _latitude;
    map["longitude"] = _longitude;
    map["cityname"] = _cityname;
    map["state"] = _state;
    return map;
  }

}