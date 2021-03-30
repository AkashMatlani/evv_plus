/// id : 1
/// deviceId : null
/// nurseId : 7
/// patientId : 1
/// notificationMessage : "Dear, Khushbu Soni your visit has been schedule on 26-03-2021 from: 12:00:00 to: 01:00:00 with Krishna Agola"
/// visitDate : "2021-03-26T00:00:00"
/// fromTime : "11:00:00"
/// toTime : "14:30:00"
/// nurse : null
/// patient : null

class NotificationResponse {
  int _id;
  dynamic _deviceId;
  int _nurseId;
  int _patientId;
  String _notificationMessage;
  String _visitDate;
  String _fromTime;
  String _toTime;
  dynamic _nurse;
  dynamic _patient;

  int get id => _id;
  dynamic get deviceId => _deviceId;
  int get nurseId => _nurseId;
  int get patientId => _patientId;
  String get notificationMessage => _notificationMessage;
  String get visitDate => _visitDate;
  String get fromTime => _fromTime;
  String get toTime => _toTime;
  dynamic get nurse => _nurse;
  dynamic get patient => _patient;

  NotificationResponse({
      int id, 
      dynamic deviceId, 
      int nurseId, 
      int patientId, 
      String notificationMessage, 
      String visitDate, 
      String fromTime, 
      String toTime, 
      dynamic nurse, 
      dynamic patient}){
    _id = id;
    _deviceId = deviceId;
    _nurseId = nurseId;
    _patientId = patientId;
    _notificationMessage = notificationMessage;
    _visitDate = visitDate;
    _fromTime = fromTime;
    _toTime = toTime;
    _nurse = nurse;
    _patient = patient;
}

  NotificationResponse.fromJson(dynamic json) {
    _id = json["id"];
    _deviceId = json["deviceId"];
    _nurseId = json["nurseId"];
    _patientId = json["patientId"];
    _notificationMessage = json["notificationMessage"];
    _visitDate = json["visitDate"];
    _fromTime = json["fromTime"];
    _toTime = json["toTime"];
    _nurse = json["nurse"];
    _patient = json["patient"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["deviceId"] = _deviceId;
    map["nurseId"] = _nurseId;
    map["patientId"] = _patientId;
    map["notificationMessage"] = _notificationMessage;
    map["visitDate"] = _visitDate;
    map["fromTime"] = _fromTime;
    map["toTime"] = _toTime;
    map["nurse"] = _nurse;
    map["patient"] = _patient;
    return map;
  }

}