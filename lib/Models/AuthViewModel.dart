import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';

class AuthViewModel{

  ValidationResult validateLogIn(String email, String password) {
    if (email.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserEmail);
    } else if(!Utils.isValidEmail(email)){
      return ValidationResult(false, LabelStr.enterValidEmail);
    }

    if (password.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserPwd);
    } else if (!Utils.isValidPassword(password)) {
      return ValidationResult(false, LabelStr.enterValidPwd);
    }
    return ValidationResult(true, "success");
  }

  void logInResult(String email, String password, ResponseCallback callback, {Function onInactiveAccount}) {
    var validateResult = validateLogIn(email, password);
    if(validateResult.isValid){
      callback(true, "Login Successful");
    } else {
      callback(false, validateResult.message);
    }
  }

  ValidationResult validateUpdatePwd(String newPwd, String confirmPwd) {
    if (newPwd.isEmpty) {
      return ValidationResult(false, LabelStr.enterNewPwd);
    } else if(!Utils.isValidPassword(newPwd)){
      return ValidationResult(false, LabelStr.enterValidPwd);
    }
    if (confirmPwd.isEmpty) {
      return ValidationResult(false, LabelStr.enterConfirmPwd);
    } else if (newPwd.compareTo(confirmPwd) != 0) {
      return ValidationResult(false, LabelStr.pwdNotMatchError);
    }
    return ValidationResult(true, "success");
  }

  void updatePwdResult(String newPwd, String confirmPwd, ResponseCallback callback, {Function onInactiveAccount}) {
    var validateResult = validateUpdatePwd(newPwd, confirmPwd);
    if(validateResult.isValid){
      callback(true, "Password updated");
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
    var validateResult = validateForgotPwd(email);
    if(validateResult.isValid){
      callback(true, "Mail Sent");
    } else {
      callback(false, validateResult.message);
    }
  }
}