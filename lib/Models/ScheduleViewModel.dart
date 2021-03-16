import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/WebService/WebService.dart';
import 'ScheduleInfoResponse.dart';


class ScheduleViewModel{
  List<ScheduleInfoResponse> pastDueScheduleList = [];
  List<ScheduleInfoResponse> upCommingScheduleList = [];
  List<ScheduleInfoResponse> completedScheduleList = [];

  void getPastDueListAPICall(String nurseId, ResponseCallback callback) {
    var params = {"NurseId":nurseId};
    WebService.getAPICall(WebService.pastDueScheduleList, params).then((response) {
      if (response.statusCode == 1) {
        for (var data in response.body) {
          pastDueScheduleList.add(ScheduleInfoResponse.fromJson(data));
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

  void getUpCommingListAPICall(String nurseId, ResponseCallback callback) {
    var params = {"NurseId":nurseId};
    WebService.getAPICall(WebService.upcommingScheduleList, params).then((response) {
      if (response.statusCode == 1) {
        for (var data in response.body) {
          upCommingScheduleList.add(ScheduleInfoResponse.fromJson(data));
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

  void getCompletedListAPICall(String nurseId, ResponseCallback callback) {
    var params = {"NurseId":nurseId};
    WebService.getAPICall(WebService.completeScheduleList, params).then((response) {
      if (response.statusCode == 1) {
        for (var data in response.body) {
          completedScheduleList.add(ScheduleInfoResponse.fromJson(data));
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
}