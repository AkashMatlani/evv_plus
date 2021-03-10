import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CompletedNoteScreen extends StatefulWidget {
  @override
  _CompletedNoteScreenState createState() => _CompletedNoteScreenState();
}

class _CompletedNoteScreenState extends State<CompletedNoteScreen> {

  var _clientNameController = TextEditingController();
  var _clinicianNameController = TextEditingController();
  var _signatureDateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 30),
              child: Text(LabelStr.lblCompletedNote, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              SizedBox(height: 15),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Text("Care Plan 1: 09/12/2020", style: AppTheme.semiBoldSFTextStyle().copyWith(color: HexColor("#2ab554"))),
              ),
              SizedBox(height: 15),
              textFieldFor(LabelStr.lblClientName, _clientNameController),
              SizedBox(height: 15),
              textFieldFor(LabelStr.lblClinicianName, _clinicianNameController),
              SizedBox(height: 15),
              textFieldFor(
                  LabelStr.lblSignatureDate,
                  _signatureDateController,
                  suffixIcon: InkWell(
                    onTap: (){
                      _selectDate(context, _signatureDateController);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      child: SvgPicture.asset(MyImage.ic_calender),
                    ),
                  ),
                readOnly: true
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.56,
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      height: 45,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor("#1785e9"),
                            HexColor("#83cff2")
                          ]),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: FlatButton(
                        child: Text(LabelStr.lblComplete,
                            style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          checkConnection().then((isConnected) {
                            if (isConnected) {
                              ToastUtils.showToast(context,
                                  "Click on complete", Colors.blue);
                            } else {
                              ToastUtils.showToast(context,
                                  LabelStr.connectionError, Colors.red);
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 30),
                    Container(
                      width: MediaQuery.of(context).size.width*0.4,
                      height: 45,
                      decoration: BoxDecoration(
                          color: HexColor("#c1def8"),
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: FlatButton(
                        child: Text(LabelStr.lblSaveExit,
                            style: AppTheme.boldSFTextStyle().copyWith(fontSize:18, color: HexColor("#2b91eb"))),
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          checkConnection().then((isConnected) {
                            if (isConnected) {
                              ToastUtils.showToast(context,
                                  "Click on save", Colors.blue);
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
              )
            ],
          ),
        ),
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
}
