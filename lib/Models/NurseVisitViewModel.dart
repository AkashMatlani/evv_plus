import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/CommentFilterResponse.dart';
import 'package:evv_plus/WebService/WebService.dart';



class NurseVisitViewModel{

  List<CommentFilterResponse> commentFilterList = [];
  String carePlanPdfPath = "";

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
        carePlanPdfPath = response.body["data"];
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
}