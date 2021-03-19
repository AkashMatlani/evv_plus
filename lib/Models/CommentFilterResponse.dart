/// patientId : 1
/// patientName : "Krishna Agola"
/// nurseName : "Sadananad Moris"
/// nurseId : 7
/// carePlanName : "Care Plan 1"

class CommentFilterResponse {
  int _patientId;
  String _patientName;
  String _nurseName;
  int _nurseId;
  String _carePlanName;

  int get patientId => _patientId;
  String get patientName => _patientName;
  String get nurseName => _nurseName;
  int get nurseId => _nurseId;
  String get carePlanName => _carePlanName;

  CommentFilterResponse({
      int patientId, 
      String patientName, 
      String nurseName, 
      int nurseId, 
      String carePlanName}){
    _patientId = patientId;
    _patientName = patientName;
    _nurseName = nurseName;
    _nurseId = nurseId;
    _carePlanName = carePlanName;
}

  CommentFilterResponse.fromJson(dynamic json) {
    _patientId = json["patientId"];
    _patientName = json["patientName"];
    _nurseName = json["nurseName"];
    _nurseId = json["nurseId"];
    _carePlanName = json["carePlanName"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["patientId"] = _patientId;
    map["patientName"] = _patientName;
    map["nurseName"] = _nurseName;
    map["nurseId"] = _nurseId;
    map["carePlanName"] = _carePlanName;
    return map;
  }

}