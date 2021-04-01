import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/NurseResponse.dart';
import 'package:evv_plus/Models/SIgnatureResponse.dart';
import 'package:evv_plus/Models/SigninVisitVerificationModel.dart';
import 'package:evv_plus/Models/UpdatedVisitTrueModel.dart';
import 'package:evv_plus/WebService/WebService.dart';

import 'CityListResponse.dart';
import 'StateListResponse.dart';
import 'UpdateNurseProfile.dart';

class AuthViewModel {
  ValidationResult validateLogIn(String email, String password) {
    if (email.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserEmail);
    } else if (!email.startsWith(RegExp(r'^[a-zA-Z]'))) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    } else if (!Utils.isValidEmail(email)) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    }

    if (password.isEmpty) {
      return ValidationResult(false, LabelStr.enterUserPwd);
    } else if (password.length < 6) {
      return ValidationResult(false, LabelStr.invalidPassword);
    }
    return ValidationResult(true, "success");
  }

  void logInResult(String email, String password, ResponseCallback callback,
      {Function onInactiveAccount}) {
    var params = {"Email": email, "Password": password};

    var validateResult = validateLogIn(email, password);
    if (validateResult.isValid) {
      WebService.postAPICall(WebService.nurseLogin, params).then((response) {
        if (response.statusCode == 1) {
          if (response.body != null) {
            PrefUtils.saveUserDataToPref(
                NurseResponse.fromJson(response.body), password);
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
    } else if (!Utils.isValidPassword(newPwd)) {
      return ValidationResult(false, LabelStr.enterValidPwd);
    }
    if (confirmPwd.isEmpty) {
      return ValidationResult(false, LabelStr.enterConfirmPwd);
    } else if (newPwd.compareTo(confirmPwd) != 0) {
      return ValidationResult(false, LabelStr.pwdNotMatchError);
    }
    return ValidationResult(true, "success");
  }

  void updatePwdResult(String nurseId, String currentPwd, String newPwd,
      String confirmPwd, ResponseCallback callback,
      {Function onInactiveAccount}) {
    var validateResult = validateUpdatePwd(newPwd, confirmPwd);
    if (validateResult.isValid) {
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
    } else if (!email.startsWith(RegExp(r'^[a-zA-Z]'))) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    } else if (!Utils.isValidEmail(email)) {
      return ValidationResult(false, LabelStr.enterValidEmail);
    }
    return ValidationResult(true, "success");
  }

  void forgotPwdResult(String email, ResponseCallback callback,
      {Function onInactiveAccount}) {
    var params = {"Email": email};
    var validateResult = validateForgotPwd(email);
    if (validateResult.isValid) {
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

  NurseResponse nurseResponse;

  void getProfileAPICall(String nurseId, ResponseCallback callback) {
    var params = {
      "NurseId": nurseId,
    };
    WebService.getAPICall(WebService.nurseDetail, params).then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          nurseResponse = NurseResponse.fromJson(response.body);
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

  UpdateNurseProfile updateNurseProfile;

  void getUpdateProfileAPICall(
      String nurseId,
      String addressOne,
      String addressTwo,
      String zipCode,
      String city,
      String state,
      String phoneNumber,
      String firstName,
      String middleName,
      String lastName,
      String gender,
      String dateOfBirth,
      String email,
      String nurseImage,
      ResponseCallback callback) {
    var params = {
      "NurseId": nurseId,
      "Address1": addressOne,
      "Address2": addressTwo,
      "ZipCode": zipCode,
      "FKcityID": city,
      "FKstateID": state,
      "PhoneNumber": phoneNumber,
      "FirstName": firstName,
      "MiddleName": middleName,
      "LastName": lastName,
      "Gender": gender,
      "DateOfBirth": dateOfBirth,
      "Email": email,
      if (nurseImage != null) "NurseImage": nurseImage else "NurseImage": "abcd"
    };

    WebService.postAPICall(WebService.nurseUpdateProfile, params)
        .then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          updateNurseProfile = UpdateNurseProfile.fromJson(response.body);
        }
        callback(true, updateNurseProfile);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  List<StateData> stateList = [];

  void getStateList(ResponseCallback callback) {
    WebService.getAPICallWithoutParmas(WebService.getState).then((response) {
      if (response.statusCode == 1) {
        for (var data in response.body) {
          stateList.add(StateData.fromJson(data));
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

  List<CityData> cityDataList = [];

  void getCityList(String stateId, ResponseCallback callback) {
    var params = {"StateId": stateId};
    WebService.getAPICall(WebService.getCity, params).then((response) {
      if (response.statusCode == 1) {
        for (var data in response.body) {
          cityDataList.add(CityData.fromJson(data));
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

  SignatureResponseModel signatureResponseModel;

  void getPatientSignature(
      String flag,
      String PatientSignature,
      String patientVoiceSign,
      String nurseId,
      String patientId,
      String visitId,
      ResponseCallback callback) {
    var params = {
      "flag": flag,
      if (PatientSignature != null) "PatientSignature": PatientSignature,
      if (patientVoiceSign != null) "patientVoiceSign": patientVoiceSign,
      "NurseId": nurseId,
      "PatientId": patientId,
      "VisitId": visitId
    };

    WebService.postAPICall(WebService.patientSignatureVoiceRecording, params)
        .then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          signatureResponseModel =
              SignatureResponseModel.fromJson(response.body);
        }
        callback(true, signatureResponseModel);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  SigninVisitVerificationModel signinVisitVerificationModel;

  void getSignInReason(
      String flag,
      String careTakerSignature,
      String careTakerReason,
      String nurseId,
      String patientId,
      String visitId,
      ResponseCallback callback) {
    var params = {
      "flag": flag,
      "CareTakerSignature": careTakerSignature,
      "CareTakerReason": careTakerReason,
      "NurseId": nurseId,
      "PatientId": patientId,
      "VisitId": visitId
    };

    WebService.postAPICall(WebService.signReasonVisitVerification, params)
        .then((response) {
      if (response.statusCode == 1) {
        if (response.body != null) {
          signinVisitVerificationModel =
              SigninVisitVerificationModel.fromJson(response.body);
        }
        callback(true, signatureResponseModel);
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  void getUpdatedVisitTrue(String nurseId, String patientId, String visitId,
      ResponseCallback callback) {
    var params = {
      "NurseId": nurseId,
      "PatientId": patientId,
      "VisitId": visitId
    };

    WebService.postAPICall(WebService.updateVisitTrue, params).then((response) {
      if (response.statusCode == 1) {
        callback(true, "");
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }
}
