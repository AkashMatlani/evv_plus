import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/NurseVisitViewModel.dart';
import 'package:evv_plus/Models/ScheduleInfoResponse.dart';
import 'package:evv_plus/Models/ScheduleViewModel.dart';
import 'package:evv_plus/Ui/CarePlanPdfScreen.dart';
import 'package:evv_plus/Ui/CustomVisitMenuScreen.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';


class CarePlanDetailsScreen extends StatefulWidget {

  CarePlanDetailsScreen(this._scheduleDetailInfo, this.isUpcommingVisit, this.fromScreen);
  ScheduleInfoResponse _scheduleDetailInfo;
  bool isUpcommingVisit;
  String fromScreen;

  @override
  _CarePlanDetailsScreenState createState() => _CarePlanDetailsScreenState();
}

class _CarePlanDetailsScreenState extends State<CarePlanDetailsScreen> {
  MediaQueryData _mediaQueryData;
  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;

  TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);

  String _nurseId="", _nurseName="";
  ScheduleViewModel _scheduleViewModel = ScheduleViewModel();
  bool isVisitStarted = false;
  String checkInTime = "00:00:00";
  String checkOutTime = "00:00:00";
  Map<PolylineId, Polyline> _mapPolylines = {};
  int _polylineIdCounter = 1;
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex;
  List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      PrefUtils.getNurseDataFromPref();
      setState(() {
        _nurseId = prefs.getInt(PrefUtils.nurseId).toString();
        _nurseName = prefs.getString(PrefUtils.fullName);
        checkInTime = Utils.convertTime(widget._scheduleDetailInfo.checkInTime.substring(0, 5));
        checkOutTime = Utils.convertTime(widget._scheduleDetailInfo.checkOutTime.substring(0, 5));
      });
    });
    _kGooglePlex = CameraPosition(
      target: LatLng(widget._scheduleDetailInfo.latitude, widget._scheduleDetailInfo.longitude),
      zoom: 14.4746,
    );

    _markers.add(
        Marker(
            markerId: MarkerId('SomeId'),
            position: LatLng(widget._scheduleDetailInfo.latitude, widget._scheduleDetailInfo.longitude),
            infoWindow: InfoWindow(
                title: 'Patient Location'
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    var boxWidth = MediaQuery.of(context).size.width*0.6/2;
    return WillPopScope(
      onWillPop: (){
        if(widget.fromScreen.compareTo("VisitComplete") == 0){
          Utils.navigateWithClearState(context, ScheduleScreen());
        } else {
          if(isVisitStarted){
            _cancelVisitDialog(context);
          } else{
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            color: HexColor("#f0f0f0"),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.max,
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
                                onTap: (){
                                  if(widget.fromScreen.compareTo("VisitComplete") == 0){
                                    Utils.navigateWithClearState(context, ScheduleScreen());
                                  } else {
                                    if(isVisitStarted){
                                      _cancelVisitDialog(context);
                                    } else{
                                      Navigator.of(context).pop();
                                    }
                                  }
                                },
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
                            child: Text(Utils.convertDate(widget._scheduleDetailInfo.visitDate, DateFormat('MM/dd/yy')), style: AppTheme.boldSFTextStyle().copyWith(fontSize: 30, color: Colors.white)),
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
                                      Text(checkInTime, style: AppTheme.mediumSFTextStyle().copyWith(color: Colors.white))
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
                                      Text(checkOutTime, style: AppTheme.mediumSFTextStyle().copyWith(color: Colors.white))
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
                          Text(widget._scheduleDetailInfo.displayAddress,
                              style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                          widget._scheduleDetailInfo.addressLine2.isNotEmpty ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(LabelStr.lblApartment, style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                                SizedBox(height: 5),
                                Text(widget._scheduleDetailInfo.addressLine2,
                                    style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                              ],
                            ),
                          ) : Container(),
                          SizedBox(height: 10),
                          Container(
                            height: 240,
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);
                              },
                              markers: Set<Marker>.of(_markers)
                              //myLocationEnabled: true,
                              //polylines: Set<Polyline>.of(_mapPolylines.values),
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
                                    child: Text(isVisitStarted ? LabelStr.lblVisitNote : LabelStr.lbStartVisit,
                                        style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      if(isVisitStarted){
                                        Utils.navigateReplaceToScreen(context, CustomVisitMenuScreen(widget._scheduleDetailInfo));
                                      } else {
                                        checkConnection().then((isConnected) {
                                          if (isConnected) {
                                            _startVisitDialog(context);
                                          } else {
                                            ToastUtils.showToast(context,
                                                LabelStr.connectionError, Colors.red);
                                          }
                                        });
                                      }
                                    },
                                  ),
                                )
                            ),
                          ) : Expanded(
                            flex: 0,
                            child: Align(
                                alignment: Alignment.bottomCenter,
                                child: widget.fromScreen.compareTo("VisitComplete") == 0 ? Container(
                                  margin: EdgeInsets.only(bottom: blockSizeVertical*10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                        HexColor("#1785e9"),
                                        HexColor("#83cff2")
                                      ]),
                                      borderRadius: BorderRadius.all(Radius.circular(5))),
                                  child: TextButton(
                                    child: Text(LabelStr.lblViewDocument,
                                        style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                                    onPressed: () {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      Utils.navigateToScreen(context, CarePlanPdfScreen("View Document"));
                                    },
                                  ),
                                ) : Container()
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: blockSizeVertical*30,
                  left: 25,
                  child: Container(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          margin: EdgeInsets.only(top: blockSizeVertical*3),
                          child: widget._scheduleDetailInfo.profilePhotoPath.isNotEmpty ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              useOldImageOnUrlChange: false,
                              imageUrl: widget._scheduleDetailInfo.profilePhotoPath,
                              placeholder: (context, url) => Container(height: 60, width: 60, alignment: Alignment.center, child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => defaultUserProfile(),
                            )
                          ) : defaultUserProfile()
                        ),
                        InkWell(
                          onTap:() {
                            _makingPhoneCall(widget._scheduleDetailInfo.phoneNumber);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: blockSizeVertical*10, top: blockSizeVertical*1),
                            child: SvgPicture.asset(MyImage.ic_call_icons, height: 150, width: 150),
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
      ),
    );
  }

  _startVisitDialog(BuildContext context){
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
                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 10),
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      child: Row(
                        children: [
                          Container(
                            height: 51,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width*0.4,
                            child: TextButton(
                                child: Text(LabelStr.lblNo, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 20,color: HexColor("#878787"))),
                                onPressed: () {
                                  if(widget.fromScreen.compareTo("VisitComplete") == 0){
                                    Utils.navigateWithClearState(context, ScheduleScreen());
                                  } else {
                                    Navigator.of(context).pop();
                                  }
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
                    )
                  ],
                )
            ),
          );
        });
  }

  _cancelVisitDialog(BuildContext context){
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
                      child: Text(LabelStr.lbCancelVisit, style: AppTheme.headerTextStyle().copyWith(fontSize: 20)),
                    ),
                    Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 10, bottom: 0, top: 10),
                          child: Text(
                            LabelStr.lblAskForCancel,
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
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
                                      cancelVisit(context);
                                    }),
                              )),
                        ],
                      ),
                    )
                  ],
                )
            ),
          );
        });
  }

  cancelVisit(BuildContext context) async {
    var visitId = await PrefUtils.getValueFor(PrefUtils.visitId);
    NurseVisitViewModel _nurseVisitViewModel = NurseVisitViewModel();

    Utils.showLoader(true, context);
    _nurseVisitViewModel.cancelRunningVisitApiCall(visitId.toString(), (isSuccess, message){
      Utils.showLoader(false, context);
      if(isSuccess){
        Navigator.of(context).pop();
        PrefUtils.setIntValue(PrefUtils.visitId, 0);
        Utils.navigateWithClearState(context, ScheduleScreen());
      } else {
        ToastUtils.showToast(context, message, Colors.red);
      }
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
    String date = formatted.split("T")[0];
    String time = formatted.split("T")[1];

    Utils.showLoader(true, context);
    _scheduleViewModel.nurseCheckInAPICall(nurseId, patientId.toString(), date, time, (isSuccess, message) {
      Utils.showLoader(false, context);
      Navigator.of(context).pop();
      if(isSuccess){
        setState(() {
          isVisitStarted = true;
          checkInTime = Utils.convertTime(time);
        });
      } else{
        setState(() {
          isVisitStarted = false;
        });
        ToastUtils.showToast(context, message, Colors.red);
      }
    });
  }
}
