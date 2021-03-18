import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/CommentFilterResponse.dart';
import 'package:evv_plus/WebService/WebService.dart';



class NurseVisitViewModel{

  List<CommentFilterResponse> commentFilterList = [];

  void getFilterListAPICall(String flag, String patientName, String carePlan, ResponseCallback callback) {
    var params = {
      "flag":flag,
      "PatientName":patientName,
      "careplan":carePlan
    };
    WebService.getAPICall(WebService.patientOrCarePlanSearch, params).then((response) {
      if (response.statusCode == 1) {
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
      return ValidationResult(false, LabelStr.enterUserEmail);
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
}