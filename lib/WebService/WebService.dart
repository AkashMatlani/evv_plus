import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:http/http.dart' as http;

class WebService {

  static const baseUrl = "http://35.231.45.54:70/api/";

  static const nurseLogin = "Nurse/NurseSignIn";
  static const changePwd = "Nurse/ChangePassword";
  static const forgotPwd = "Nurse/ForgetPassword";
  static const pastDueScheduleList = "Patient/PatientPastDueListing";
  static const upcommingScheduleList = "Patient/PatientUpComingListing";
  static const completeScheduleList = "Patient/PatientCompletedListing";
  static const nurseDetail = "Nurse/ViewNurse";
  static const nurseUpdateProfile = "Nurse/UpdatenurseProfile";
  static const getState = "Nurse/GetAllState";
  static const getCity = "Nurse/GetCityByState";
  static Future<ServerResponse> getAPICall(String apiName, Map<String, dynamic> params) async {
    var url = baseUrl + apiName;
    print("Get Url :"+url);
    var postUri = Uri.parse(url);

    var response;
    if(params != null){
      String queryString = Uri(queryParameters: params).query;
      var requestUrl = url + '?' + queryString;
      var postUri = Uri.parse(requestUrl);
      response = await http.get(postUri);
    } else {
      response = await http.get(postUri);
    }
    var jsValue = json.decode(response.body);
    ServerResponse serverResponse = ServerResponse.withJson(jsValue);
    return serverResponse;
  }


  static Future<ServerResponse> getAPICallWithoutParmas(String apiName) async {
    var url = baseUrl + apiName;
    print("Get Url :"+url);
    var postUri = Uri.parse(url);

    var response;
      var requestUrl = url;
      var postUris = Uri.parse(requestUrl);
      response = await http.get(postUris);

    var jsValue = json.decode(response.body);
    ServerResponse serverResponse = ServerResponse.withJson(jsValue);
    return serverResponse;
  }
  static Future<ServerResponse> postAPICall(
      String apiName, Map<String, dynamic> params) async {
    var url = baseUrl + apiName;
    var postUri = Uri.parse(url);

    print("\n");
    print("Request URL: $url");
    print("Request parameters: $params");
    print("\n");

    var completer = Completer<ServerResponse>();

    http.post(postUri, body: params)
        .then((response) {
      print(response.body);

      var jsValue = json.decode(response.body);
      var serverResponseObj = ServerResponse.withJson(jsValue);
      completer.complete(serverResponseObj);
    }).catchError((error) {
      var response = ServerResponse();

      switch (error.runtimeType) {
        case SocketException:
          print("socekt exception");
          response.message = error.osError.message;
          break;
        default:
          response.message = error.toString();
          break;
      }
      response.statusCode = 0;
      completer.complete(response);
    });
    return completer.future;
  }
}

class ServerResponse {
  var message = LabelStr.serverError;
  var body;
  var statusCode = 0;

  ServerResponse();

  ServerResponse.withJson(Map<String, dynamic> jsonObj) {
    print("parsing response");
    String status = jsonObj["status"];
    this.message = jsonObj["message"];
    if (jsonObj["data"] != null)
      this.body = jsonObj["data"];
    else
      this.body = jsonObj;
    this.statusCode = int.parse(status);
    print("parsing response done");
  }
}