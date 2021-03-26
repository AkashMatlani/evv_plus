class SigninVisitVerificationModel {
  String status;
  String message;
  Data data;

  SigninVisitVerificationModel({this.status, this.message, this.data});

  SigninVisitVerificationModel.fromJson(Map<String, dynamic> json) {
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
  int id;
  Null patientSignature;
  Null patientVoiceSign;
  String careTakerSignature;
  String careTakerReason;
  int nurseId;
  int patientId;
  int visitId;
  String createdDate;
  String modifiedDate;
  int createdBy;
  int modifiedBy;

  Data(
      {this.id,
        this.patientSignature,
        this.patientVoiceSign,
        this.careTakerSignature,
        this.careTakerReason,
        this.nurseId,
        this.patientId,
        this.visitId,
        this.createdDate,
        this.modifiedDate,
        this.createdBy,
        this.modifiedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientSignature = json['patientSignature'];
    patientVoiceSign = json['patientVoiceSign'];
    careTakerSignature = json['careTakerSignature'];
    careTakerReason = json['careTakerReason'];
    nurseId = json['nurseId'];
    patientId = json['patientId'];
    visitId = json['visitId'];
    createdDate = json['createdDate'];
    modifiedDate = json['modifiedDate'];
    createdBy = json['createdBy'];
    modifiedBy = json['modifiedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['patientSignature'] = this.patientSignature;
    data['patientVoiceSign'] = this.patientVoiceSign;
    data['careTakerSignature'] = this.careTakerSignature;
    data['careTakerReason'] = this.careTakerReason;
    data['nurseId'] = this.nurseId;
    data['patientId'] = this.patientId;
    data['visitId'] = this.visitId;
    data['createdDate'] = this.createdDate;
    data['modifiedDate'] = this.modifiedDate;
    data['createdBy'] = this.createdBy;
    data['modifiedBy'] = this.modifiedBy;
    return data;
  }
}