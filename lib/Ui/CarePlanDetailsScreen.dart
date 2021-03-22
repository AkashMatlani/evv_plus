import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/ScheduleInfoResponse.dart';
import 'package:evv_plus/Models/ScheduleViewModel.dart';
import 'package:evv_plus/Ui/CustomVisitMenuScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CarePlanDetailsScreen extends StatefulWidget {

  CarePlanDetailsScreen(this._scheduleDetailInfo, this.isUpcommingVisit);
  ScheduleInfoResponse _scheduleDetailInfo;
  bool isUpcommingVisit;

  @override
  _CarePlanDetailsScreenState createState() => _CarePlanDetailsScreenState();
}

class _CarePlanDetailsScreenState extends State<CarePlanDetailsScreen> {
  MediaQueryData _mediaQueryData;
  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;

  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.012429, 72.510775),
    zoom: 14.4746,
  );

  TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);

  String _nurseId="", _nurseName="";
  ScheduleViewModel _scheduleViewModel = ScheduleViewModel();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      PrefUtils.getNurseDataFromPref();
      setState(() {
        _nurseId = prefs.getInt(PrefUtils.nurseId).toString();
        _nurseName = prefs.getString(PrefUtils.fullName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    var boxWidth = MediaQuery.of(context).size.width*0.6/2;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          color: HexColor("#f0f0f0"),
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  Container(
                    height: blockSizeVertical*40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.zero,
                            topLeft: Radius.zero,
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.circular(100)
                        ),
                        gradient: LinearGradient(
                            colors: [
                              HexColor("#1785e9"),
                              HexColor("#83cff2")
                            ]
                        )
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        Row(
                          children: [
                            InkWell(
                              onTap: (){ Navigator.of(context).pop();},
                              child: Container(
                                child: Icon(Icons.arrow_back, color: Colors.white),
                                margin: EdgeInsets.only(left: 10),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text(widget._scheduleDetailInfo.carePlanName, style: AppTheme.mediumSFTextStyle().copyWith(fontSize:22, color: Colors.white)),
                                )
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          alignment: Alignment.center,
                          child: Text(Utils.convertDate(widget._scheduleDetailInfo.visitDate, DateFormat('MMMM dd, yyyy')), style: AppTheme.boldSFTextStyle().copyWith(fontSize: 30, color: Colors.white)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          height: MediaQuery.of(context).size.height*0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(width: 0.5, color: Colors.white)
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Container(
                                width: boxWidth - 2,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(LabelStr.lblCheckIn, style: AppTheme.regularSFTextStyle().copyWith(fontSize:14, color: Colors.white)),
                                    SizedBox(height: 3),
                                    Text(widget._scheduleDetailInfo.checkInTime, style: AppTheme.mediumSFTextStyle().copyWith(color: Colors.white))
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height*0.1,
                                width: 1,
                                color: Colors.white,
                              ),
                              Container(
                                width: boxWidth - 2,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(LabelStr.lblCheckout, style: AppTheme.regularSFTextStyle().copyWith(fontSize:14, color: Colors.white)),
                                    SizedBox(height: 3),
                                    Text(widget._scheduleDetailInfo.checkOutTime, style: AppTheme.mediumSFTextStyle().copyWith(color: Colors.white))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: blockSizeVertical*80,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 25, top: 50, right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40,),
                        Container(
                          child: Text(widget._scheduleDetailInfo.firstName+" " +
                              widget._scheduleDetailInfo.middleName+" " +
                              widget._scheduleDetailInfo.lastName,
                              style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 34)),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LabelStr.lblAge, style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                                SizedBox(height: 5),
                                Text(_getAgeOfPatient(widget._scheduleDetailInfo.birthdate), style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                              ],
                            ),
                            SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LabelStr.lbNurse, style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                                SizedBox(height: 5),
                                Text(_nurseName, style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(LabelStr.lbPatientAddress, style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                        SizedBox(height: 5),
                        Text(widget._scheduleDetailInfo.addressLine1+", "+widget._scheduleDetailInfo.addressLine2,
                            style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                        SizedBox(height: 10),
                        /*Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 1, color: Colors.black12)
                        ),
                        height: blockSizeVertical*30,
                        alignment: Alignment.center,
                        child: Text("Map view"),
                      ),*/
                        Container(
                          height: 240,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        widget.isUpcommingVisit ? Expanded(
                          flex: 0,
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: EdgeInsets.only(bottom: blockSizeVertical*10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                      HexColor("#1785e9"),
                                      HexColor("#83cff2")
                                    ]),
                                    borderRadius: BorderRadius.all(Radius.circular(5))),
                                child: TextButton(
                                  child: Text(LabelStr.lbStartVisit,
                                      style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                                  onPressed: () {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    checkConnection().then((isConnected) {
                                      if (isConnected) {
                                        _showDialog(context);
                                      } else {
                                        ToastUtils.showToast(context,
                                            LabelStr.connectionError, Colors.red);
                                      }
                                    });
                                  },
                                ),
                              )
                          ),
                        ) : Container(),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: blockSizeVertical*30,
                left: 25,
                right: -50,
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(image: AssetImage(MyImage.ic_rectangle,),height: 160,width: 160,),
                      /* Container(
                      height: ic_rectangle,
                      width: blockSizeHorizontal*25,
                      margin: EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image(
                          image: NetworkImage(
                              'https://www.tutorialkart.com/img/hummingbird.png'),
                        ),
                      ),
                    ),       */             InkWell(
                        onTap:() {
                          _makingPhoneCall(widget._scheduleDetailInfo.phoneNumber);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: blockSizeVertical*5),
                          child: Expanded(
                              child: SvgPicture.asset(MyImage.ic_call_icons, height: 160,width: 160,)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext context){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)), //this right here
            child: Container(
                height:blockSizeVertical*20,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Text(LabelStr.lbStartVisit, style: AppTheme.headerTextStyle().copyWith(fontSize: 20)),
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 10, bottom: 0, top: 10),
                          child: Text(
                            LabelStr.lblAskStartVisit,
                            style: AppTheme.mediumSFTextStyle().copyWith(color: HexColor("#3d3d3d")),
                            textAlign: TextAlign.center,
                          ),
                        )
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width,
                      color: HexColor("#f5f5f5"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 51,
                        child: Row(
                          children: [
                            Container(
                              height: 51,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width*0.4,
                              child: TextButton(
                                  child: Text(LabelStr.lblNo, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 20,color: HexColor("#878787"))),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ),
                            SizedBox(width: 1),
                            Container(
                              width: 1,
                              height: 51,
                              color: HexColor("#f5f5f5"),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 51,
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width*0.4,
                                  child: TextButton(
                                      child: Text(LabelStr.lblYes, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 20, color: HexColor("#1a87e9"))),
                                      onPressed: () {
                                        _nurseChexckInRequest(context, _nurseId, widget._scheduleDetailInfo.patientId);
                                      }),
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                )
            ),
          );
        });
  }

  _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime)
      setState(() {
        _selectedTime = picked;
        controller.text = _formatTimeOfDay(_selectedTime);
      });
  }

  _formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  _makingPhoneCall(String number) async {
    String  url ='tel:'+number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _getAgeOfPatient(String Date){
    DateTime dob = DateTime.parse(Date);
    Duration dur =  DateTime.now().difference(dob);
    String differenceInYears = (dur.inDays/365).floor().toString();
    return differenceInYears + ' Years';
  }

  void _nurseChexckInRequest(BuildContext context, String nurseId, int patientId) {
    DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');
    String formatted = formatter.format(DateTime.now());
    String checkInDate = formatted.split("T")[0];
    String checkInTime = formatted.split("T")[1];

    _scheduleViewModel.nurseCheckInAPICall(nurseId, patientId.toString(), checkInDate, checkInTime, (isSuccess, message) {
      if(isSuccess){
        ToastUtils.showToast(context, message, Colors.green);
        Timer(
          Duration(seconds: 2),
              () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CustomVisitMenuScreen(widget._scheduleDetailInfo))),
        );
      } else{
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }
}
