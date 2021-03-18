import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/WebService/WebService.dart';

import 'ScheduleInfoResponse.dart';


class ScheduleViewModel{
  List<ScheduleInfoResponse> pastDueScheduleList = [];
  List<ScheduleInfoResponse> upCommingScheduleList = [];
  List<ScheduleInfoResponse> completedScheduleList = [];

  int pastDueVisitCount=0, upcommingVisitCount=0, completedVisitCount=0;

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

  void getScheduleCountAPICall(String nurseId, ResponseCallback callback) {
    var params = {"NurseId":nurseId};
    WebService.getAPICall(WebService.scheduleCount, params).then((response) {
      if (response.statusCode == 1) {
        pastDueVisitCount = response.body["pastDueVisitCount"];
        upcommingVisitCount = response.body["upComingVisitCount"];
        completedVisitCount = response.body["completedVisitCount"];
        callback(true, "");
      } else {
        callback(false, response.message);
      }
    }).catchError((error) {
      print(error);
      callback(false, LabelStr.serverError);
    });
  }

  void nurseCheckInAPICall(String nurseId, String patientId, String checkInDate, String checkInTime, ResponseCallback callback, {Function onInactiveAccount}) {
    var params = {
      "PatientId": patientId,
      "NurseId": nurseId,
      "CheckOutTime": "00:00:00",
      "CheckOutDate":"",
      "CheckInTime":checkInTime,
      "CheckInDate":checkInDate,
    };

    WebService.postAPICall(WebService.nurseVisitCheckInTime, params).then((response) {
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