import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/NotificationResponse.dart';
import 'package:evv_plus/Models/NurseVisitViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  int nurseId;
  List<NotificationResponse> _notificationList = [];
  NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNurseid();
  }

  getNurseid() async{
    nurseId = await PrefUtils.getValueFor(PrefUtils.nurseId);
    getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 30),
            child: Text(
              LabelStr.lblNotification,
              style: AppTheme.boldSFTextStyle()
                  .copyWith(fontSize: 26, color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: HexColor("#efefef"),
            ),
            _notificationList.length == 0 ? emptyListView() : Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView.separated(
                  itemCount: _notificationList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                                _notificationList[index].notificationMessage,
                                style: AppTheme.semiBoldSFTextStyle().copyWith(
                                    fontSize: 16, color: HexColor("#3d3d3d")),
                              )
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: Text(
                                    Utils.convertDate(_notificationList[index].visitDate, DateFormat("dd MMM yyyy")),
                                    style: AppTheme.mediumSFTextStyle()
                                        .copyWith(
                                        fontSize: 12,
                                        color: HexColor("#838383")),
                                  )),
                              Container(
                                height: 7,
                                width: 7,
                                margin: EdgeInsets.only(top: 13,left: 5),
                                child: SvgPicture.asset(MyImage.ic_fill_circle, color: HexColor("#228de9")),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(5, 15, 0, 0),
                                  child: Text(
                                    Utils.convertTime(_notificationList[index].fromTime.substring(0, 5)),
                                    style: AppTheme.mediumSFTextStyle()
                                        .copyWith(
                                        fontSize: 12,
                                        color: HexColor("#838383")),
                                  )),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )
    ); //
  }

  final Color textUnreadGreenColor = Color.fromARGB(255, 8, 211, 111);

  Widget buildUnreadMessages() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 5,
        width: 5,
        decoration: BoxDecoration(
          color: textUnreadGreenColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  emptyListView() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: isLoading ? Container() : Text(LabelStr.lblNoData, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 18, color: Colors.red)),
      ),
    );
  }

  void getNotificationList() {
    Utils.showLoader(true, context);
    _nurseVisitViewModel.notificationListApiCall(nurseId.toString(), (isSuccess, message){
      Utils.showLoader(false, context);
      isLoading = false;
      if(isSuccess){
        setState(() {
          _notificationList = [];
          _notificationList = _nurseVisitViewModel.notificationList;
        });
        updateNotificationStatus();
      } else {
        setState(() {
          _notificationList = [];
        });
      }
    });
  }

  updateNotificationStatus() {
    _nurseVisitViewModel.markAsReadNotificationApiCall(nurseId.toString(), (isSuccess, message){
      if(isSuccess){
       setState(() {
         Utils.notificationCount = 0;
       });
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }
}
