/// id : 99
/// nurseId : 7
/// patientId : 4
/// checkInDate : "2021-03-22T00:00:00"
/// checkInTime : "00:00:00"
/// checkOutDate : "2021-03-25T00:00:00+05:30"
/// checkOutTime : "14:24:42.9687703"
/// clientName : "mayuuuu"
/// clinicianName : "mayurii"
/// signatureDate : "2021-03-20T00:00:00"

class CompletedNoteResponse {
  int _id;
  int _nurseId;
  int _patientId;
  String _checkInDate;
  String _checkInTime;
  String _checkOutDate;
  String _checkOutTime;
  String _clientName;
  String _clinicianName;
  String _signatureDate;

  int get id => _id;
  int get nurseId => _nurseId;
  int get patientId => _patientId;
  String get checkInDate => _checkInDate;
  String get checkInTime => _checkInTime;
  String get checkOutDate => _checkOutDate;
  String get checkOutTime => _checkOutTime;
  String get clientName => _clientName;
  String get clinicianName => _clinicianName;
  String get signatureDate => _signatureDate;

  CompletedNoteResponse({
      int id, 
      int nurseId, 
      int patientId, 
      String checkInDate, 
      String checkInTime, 
      String checkOutDate, 
      String checkOutTime, 
      String clientName, 
      String clinicianName, 
      String signatureDate}){
    _id = id;
    _nurseId = nurseId;
    _patientId = patientId;
    _checkInDate = checkInDate;
    _checkInTime = checkInTime;
    _checkOutDate = checkOutDate;
    _checkOutTime = checkOutTime;
    _clientName = clientName;
    _clinicianName = clinicianName;
    _signatureDate = signatureDate;
}

  CompletedNoteResponse.fromJson(dynamic json) {
    _id = json["id"];
    _nurseId = json["nurseId"];
    _patientId = json["patientId"];
    _checkInDate = json["checkInDate"];
    _checkInTime = json["checkInTime"];
    _checkOutDate = json["checkOutDate"];
    _checkOutTime = json["checkOutTime"];
    _clientName = json["clientName"];
    _clinicianName = json["clinicianName"];
    _signatureDate = json["signatureDate"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["nurseId"] = _nurseId;
    map["patientId"] = _patientId;
    map["checkInDate"] = _checkInDate;
    map["checkInTime"] = _checkInTime;
    map["checkOutDate"] = _checkOutDate;
    map["checkOutTime"] = _checkOutTime;
    map["clientName"] = _clientName;
    map["clinicianName"] = _clinicianName;
    map["signatureDate"] = _signatureDate;
    return map;
  }

}