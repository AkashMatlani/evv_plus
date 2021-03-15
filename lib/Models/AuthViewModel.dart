import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/NurseResponse.dart';
import 'package:evv_plus/WebService/WebService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel{

  ValidationResult validateLogIn(String email, String password) {
    if (email.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserEmail);
    } else if(!Utils.isValidEmail(email)){
      return ValidationResult(false, LabelStr.enterValidEmail);
    }

    if (password.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserPwd);
    } /*else if (!Utils.isValidPassword(password)) {
      return ValidationResult(false, LabelStr.enterValidPwd);
    }*/
    return ValidationResult(true, "success");
  }

  void logInResult(String email, String password, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {
      "Email": email,
      "Password": password};

    var validateResult = validateLogIn(email, password);
    if(validateResult.isValid){
      WebService.postAPICall(WebService.nurseLogin, params).then((response) {
        if (response.statusCode == 1) {
          if (response.body != null) {
            PrefUtils.saveUserDataToPref(NurseResponse.fromJson(response.body));
            callback(true, "");
          }
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

  ValidationResult validateUpdatePwd(String newPwd, String confirmPwd) {
    if (newPwd.isEmpty) {
      return ValidationResult(false, LabelStr.enterNewPwd);
    } /*else if(!Utils.isValidPassword(newPwd)){
      return ValidationResult(false, LabelStr.enterValidPwd);
    }*/
    if (confirmPwd.isEmpty) {
      return ValidationResult(false, LabelStr.enterConfirmPwd);
    } /*else if (newPwd.compareTo(confirmPwd) != 0) {
      return ValidationResult(false, LabelStr.pwdNotMatchError);
    }*/
    return ValidationResult(true, "success");
  }

  void updatePwdResult(String nurseId, String currentPwd, String newPwd, String confirmPwd, ResponseCallback callback, {Function onInactiveAccount}) {
    var validateResult = validateUpdatePwd(newPwd, confirmPwd);
    if(validateResult.isValid){
      var params = {
        "Nurseid": nurseId,
        "CurrentPassword": currentPwd,
        "NewPassword": newPwd,
        "ConfirmPassword": confirmPwd
      };

      WebService.postAPICall(WebService.changePwd, params).then((response) {
        if (response.statusCode == 1) {
          PrefUtils.setStringValue(PrefUtils.password, newPwd);
          PrefUtils.setBoolValue(PrefUtils.isFirstTimeLogin, false);
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

  ValidationResult validateForgotPwd(String email) {
    if (email.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserEmail);
    } else if(!Utils.isValidEmail(email)){
      return ValidationResult(false, LabelStr.enterValidEmail);
    }
    return ValidationResult(true, "success");
  }

  void forgotPwdResult(String email, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {"Email": email};
    var validateResult = validateForgotPwd(email);
    if(validateResult.isValid){
      WebService.postAPICall(WebService.forgotPwd, params).then((response) {
        if (response.statusCode == 1) {
          PrefUtils.setStringValue(PrefUtils.password, "");
          PrefUtils.setBoolValue(PrefUtils.isLoggedIn, false);
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