import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:evv_plus/Ui/VerificationMenuScreen.dart';
import 'package:evv_plus/Ui/VisitVerificationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TaskWithDateDetailsScreen extends StatefulWidget {
  @override
  _TaskWithDateDetailsScreenState createState() => _TaskWithDateDetailsScreenState();
}

class _TaskWithDateDetailsScreenState extends State<TaskWithDateDetailsScreen> {

  var _clientNameController = TextEditingController();
  var _clinicianNameController = TextEditingController();
  var _checkInDateController = TextEditingController();
  var _checkInTimeController = TextEditingController();
  var _checkOutDateController = TextEditingController();
  var _checkOutTimeController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay(hour: 00, minute: 00);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          title: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 30),
            child: Text("Task 09/12/2020", style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
          ),
          backgroundColor: Colors.white10,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              ToastUtils.showToast(context, "Back press", Colors.blueAccent);
            },
          )
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: HexColor("#efefef"),
          ),
          SizedBox(height: 15),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFieldFor(LabelStr.lblClientName, _clientNameController),
                  SizedBox(height: 15),
                  textFieldFor(LabelStr.lblClinicianName, _clinicianNameController),
                  SizedBox(height: 15),
                  Text(LabelStr.lblDateNote, style: AppTheme.semiBoldSFTextStyle()),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: HexColor("#d2d2d2"), width: 1),
                        color: Colors.white
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LabelStr.lblCheckIn, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 14, color: HexColor("#3d3d3d"))),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.42,
                              child: textFieldFor(
                                  "09/03/2020",
                                  _checkInDateController,
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      _selectDate(context, _checkInDateController);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                                      child: SvgPicture.asset(MyImage.ic_calender),
                                    ),
                                  ),
                                  readOnly: true
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width*0.02),
                            Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: textFieldFor(
                                  "11:30 am",
                                  _checkInTimeController,
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      _selectTime(context, _checkInTimeController);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                                      child: SvgPicture.asset(MyImage.ic_clock),
                                    ),
                                  ),
                                  readOnly: true
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: HexColor("#d2d2d2"), width: 1),
                        color: Colors.white
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(LabelStr.lblCheckout, style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 14, color: HexColor("#3d3d3d"))),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.42,
                              child: textFieldFor(
                                  "09/03/2020",
                                  _checkOutDateController,
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      _selectDate(context, _checkOutDateController);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                                      child: SvgPicture.asset(MyImage.ic_calender),
                                    ),
                                  ),
                                  readOnly: true
                              ),
                            ),
                            SizedBox(width: MediaQuery.of(context).size.width*0.02),
                            Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: textFieldFor(
                                  "11:30 am",
                                  _checkOutTimeController,
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      _selectTime(context, _checkOutTimeController);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                                        child: SvgPicture.asset(MyImage.ic_clock)
                                    ),
                                  ),
                                  readOnly: true
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                 // SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  HexColor("#1785e9"),
                                  HexColor("#83cff2")
                                ]),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            child: TextButton(
                              child: Text(LabelStr.lblCollectSign,
                                  style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                              onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                checkConnection().then((isConnected) {
                                  if (isConnected) {
                                    /*ToastUtils.showToast(context,
                                        "Client sign collection clicked", Colors.green);*/
                                    Utils.navigateToScreen(context, VerificationMenuScreen());
                                  } else {
                                    ToastUtils.showToast(context,
                                        LabelStr.connectionError, Colors.red);
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                color: HexColor("#c1def8")),
                            child: TextButton(
                              child: Text(LabelStr.lblCancelVerification,
                                  style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: HexColor("#2b91eb"))),
                              onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                checkConnection().then((isConnected) {
                                  if (isConnected) {
                                 /*   ToastUtils.showToast(context,
                                        "Client sign collection clicked", Colors.green);*/
                                    Utils.navigateReplaceToScreen(context, ScheduleScreen());
                                  } else {
                                    ToastUtils.showToast(context,
                                        LabelStr.connectionError, Colors.red);
                                  }
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
        String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
        controller.text = formattedDate;
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
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }
}
