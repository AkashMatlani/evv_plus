import 'dart:io';

import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/CommentFilterResponse.dart';
import 'package:evv_plus/Models/CompletedNoteResponse.dart';
import 'package:evv_plus/Models/NotificationResponse.dart';
import 'package:evv_plus/WebService/WebService.dart';



class NurseVisitViewModel{

  List<CommentFilterResponse> commentFilterList = [];
  List<NotificationResponse> notificationList = [];
  String carePlanPdfPath = "";
  int count = 0;
  CompletedNoteResponse completedNoteResponse = CompletedNoteResponse();

  void getFilterListAPICall(String flag, String patientName, String carePlan, ResponseCallback callback) {
    var params = {
      "flag":flag,
      "PatientName":patientName,
      "careplan":carePlan
    };
    WebService.getAPICall(WebService.patientOrCarePlanSearch, params).then((response) {
      if (response.statusCode == 1) {
        commentFilterList = [];
        for (var data in response.body) {
          commentFilterList.add(CommentFilterResponse.fromJson(data));
        }
        callback(true, "");
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  ValidationResult validateCommentField(String comment) {
    if (comment.isEmpty) {
      return ValidationResult(false, LabelStr.enterComment);
    } else if(comment.length < 2 && comment.length > 250){
      return ValidationResult(false, LabelStr.invalidComment);
    }
    return ValidationResult(true, "success");
  }

  void commentApiCall(String flag, String patientId, String nurseId, String comment, String careplane, ResponseCallback callback, {Function onInactiveAccount}) {
    var validateResult = validateCommentField(comment);
    if(validateResult.isValid){
      var params = {
        "flag": flag,
        "PatientId": patientId,
        "NurseId": nurseId,
        "Comment": comment,
        "Name": careplane
      };
      WebService.postAPICall(WebService.patientOrCarePlanComment, params).then((response) {
        if (response.statusCode == 1) {
          callback(true, response.message);
        } else {
          callback(false, response.message);
        }
      }).catchError((error) {
        print(error);
        callback(false, LabelStr.serverError);
      });
    } else {
      callback(false, validateResult.message);
    }
  }

  void getCarePlanPdf(ResponseCallback callback) {
    WebService.getAPICall(WebService.carePlanPdf, {}).then((response) {
      if (response.statusCode == 1) {
        carePlanPdfPath = response.body;
        callback(true, "Care plan pdf file found");
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  void dailyLivingTaskApiCall(String patientId, String queName, String answer, String comment, String date, String nurseId, String visitId, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {
      "PatientId": patientId,
      "QuestionName": queName,
      "Answer": answer,
      "OptionalText": comment,
      "CreatedDate": date,
      "NurseId": nurseId,
      "VisitId": visitId
    };
    WebService.postAPICall(WebService.dailyLivingTask, params).then((response) {
      if (response.statusCode == 1) {
        callback(true, response.message);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  void completeVisitNoteApiCall(String visitId, String nurseId, String patientId, String clientName, String clinicianName, String signatureDate, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {
      "VisitId": visitId,
      "NurseId": nurseId,
      "PatientId": patientId,
      "ClientName": clientName,
      "ClinicianName": clinicianName,
      "SignatureDate": signatureDate
    };
    WebService.postAPICall(WebService.updateVisitCompleteNote, params).then((response) {
      if (response.statusCode == 1) {
        completedNoteResponse = CompletedNoteResponse.fromJson(response.body);
        callback(true, response.message);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  void cancelRunningVisitApiCall(String visitId, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {
      "VisitId": visitId
    };
    WebService.getAPICall(WebService.cancelVisit, params).then((response) {
      if (response.statusCode == 1) {
        callback(true, response.message);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  void notificationListApiCall(String nurseId, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {
      "NurseId": nurseId
    };
    WebService.getAPICall(WebService.getNotification, params).then((response) {
      if (response.statusCode == 1) {
        notificationList = [];
        for (var data in response.body) {
          notificationList.add(NotificationResponse.fromJson(data));
        }
        callback(true, response.message);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  void getNotificationCountApiCall(String nurseId, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {
      "NurseId": nurseId
    };
    WebService.getAPICall(WebService.notificationCount, params).then((response) {
      if (response.statusCode == 1) {
        if(response.body != null){
          count = response.body;
        } else {
          count = 0;
        }
        callback(true, response.message);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  void markAsReadNotificationApiCall(String nurseId, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {
      "NurseId": nurseId
    };
    WebService.getAPICall(WebService.markAsRead, params).then((response) {
      if (response.statusCode == 1) {
        callback(true, response.message);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  void uploadIncidentFormApiCall(String nurseId, String patientId, String filePath, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {
      "NurseId": nurseId,
      "PatientId": patientId,
    };

    WebService.multiPartAPI(WebService.uploadIncidentForm, params, "file", filePath).then((response) {
      if (response.statusCode == 1) {
        callback(true, response.message);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }
}