/// id : 346
/// deviceId : "eMayLIiBRpevbrEjA19U1r:APA91bGAopqp0aGv_ECQz5IPET5QfJcKs7JppTsYsv7ceE-LgilfqxkCu5KisoDnKFHP0armOOpxehvs_9llxzUhCD0zQJXBkzaWL7nrACGCl3zq5lj3avU0nWOg6-jgNWeUHUxzuf2P"
/// nurseId : 58
/// patientId : 239
/// notificationMessage : "Dear Sadanand Moris, This is friendly reminder of your upcoming visit with Aneri Bhatt on 04/28/21"
/// visitDate : "2021-04-28T14:00:00.397"
/// currentDate : "2021-04-28T18:46:57.67"
/// fromTime : "14:00:00.3980826"
/// toTime : "14:00:00.3980826"
/// currentTime : "18:55:00.1141797"
/// isRead : false
/// isSchedule : false
/// patient : null

class NotificationResponse {
  int _id;
  String _deviceId;
  int _nurseId;
  int _patientId;
  String _notificationMessage;
  String _visitDate;
  String _currentDate;
  String _fromTime;
  String _toTime;
  String _currentTime;
  bool _isRead;
  bool _isSchedule;
  dynamic _patient;

  int get id => _id;
  String get deviceId => _deviceId;
  int get nurseId => _nurseId;
  int get patientId => _patientId;
  String get notificationMessage => _notificationMessage;
  String get visitDate => _visitDate;
  String get currentDate => _currentDate;
  String get fromTime => _fromTime;
  String get toTime => _toTime;
  String get currentTime => _currentTime;
  bool get isRead => _isRead;
  bool get isSchedule => _isSchedule;
  dynamic get patient => _patient;

  NotificationResponse({
      int id, 
      String deviceId, 
      int nurseId, 
      int patientId, 
      String notificationMessage, 
      String visitDate, 
      String currentDate, 
      String fromTime, 
      String toTime, 
      String currentTime, 
      bool isRead, 
      bool isSchedule, 
      dynamic patient}){
    _id = id;
    _deviceId = deviceId;
    _nurseId = nurseId;
    _patientId = patientId;
    _notificationMessage = notificationMessage;
    _visitDate = visitDate;
    _currentDate = currentDate;
    _fromTime = fromTime;
    _toTime = toTime;
    _currentTime = currentTime;
    _isRead = isRead;
    _isSchedule = isSchedule;
    _patient = patient;
}

  NotificationResponse.fromJson(dynamic json) {
    _id = json["id"];
    _deviceId = json["deviceId"];
    _nurseId = json["nurseId"];
    _patientId = json["patientId"];
    _notificationMessage = json["notificationMessage"];
    _visitDate = json["visitDate"];
    _currentDate = json["currentDate"];
    _fromTime = json["fromTime"];
    _toTime = json["toTime"];
    _currentTime = json["currentTime"];
    _isRead = json["isRead"];
    _isSchedule = json["isSchedule"];
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
    map["currentDate"] = _currentDate;
    map["fromTime"] = _fromTime;
    map["toTime"] = _toTime;
    map["currentTime"] = _currentTime;
    map["isRead"] = _isRead;
    map["isSchedule"] = _isSchedule;
    map["patient"] = _patient;
    return map;
  }

}