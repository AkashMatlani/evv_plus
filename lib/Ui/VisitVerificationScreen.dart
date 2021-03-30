import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:evv_plus/Models/CompletedNoteResponse.dart';
import 'package:evv_plus/Ui/UnableToSignInScreen.dart';
import 'package:evv_plus/Ui/VerificationMenuScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ClientPatientSignScreen.dart';

enum SingingCharacter { Physical, mental, other }

class VisitVerificationScreen extends StatefulWidget {
  CompletedNoteResponse completedNoteResponse;

  VisitVerificationScreen(this.completedNoteResponse, [this.finalValue]);

  var finalValue;

  @override
  _VisitVerificationScreenState createState() =>
      _VisitVerificationScreenState();
}

class _VisitVerificationScreenState extends State<VisitVerificationScreen> {
  var careTakerReason;
  var reasonController = new TextEditingController();
  AuthViewModel _nurseViewModel = AuthViewModel();

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
            LabelStr.lblVisitVerification,
            style: AppTheme.boldSFTextStyle().copyWith(fontSize: 22),
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
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: constraints.copyWith(
                  minHeight: constraints.maxHeight,
                  maxHeight: double.infinity,
                ),
                child: IntrinsicHeight(
                    child: Column(children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: HexColor("#efefef"),
                  ),
                  Column(
                    children: [
                      widget.finalValue == SingingCharacter.other.toString()
                          ? Container()
                          : Container(
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor("#e9e9e9"),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 20, 0, 0),
                                        child: Text(
                                          LabelStr.lblGetPatientSign,
                                          style: AppTheme.boldSFTextStyle()
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: HexColor("#3d3d3d")),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: HexColor("#e9e9e9"),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        reasonSelected();
                                        Utils.navigateToScreen(
                                            context,
                                            ClientPatientSignScreen(
                                                widget.completedNoteResponse,careTakerReason));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 30,
                                            right: 20,
                                            left: 20,
                                            bottom: 20),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor("#1785e9"),
                                              HexColor("#83cff2")
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: TextButton(
                                          child: Text(
                                              LabelStr.lblGetCaretakerSignature,
                                              style: AppTheme.boldSFTextStyle()
                                                  .copyWith(
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                          onPressed: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            checkConnection()
                                                .then((isConnected) {
                                              reasonSelected();
                                              Utils.navigateToScreen(
                                                  context,
                                                  ClientPatientSignScreen(
                                                      widget.completedNoteResponse,careTakerReason));
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                      widget.finalValue == SingingCharacter.other.toString()
                          ? Container(
                              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                              color: Colors.white,
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor("#e9e9e9"),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding:
                                            EdgeInsets.fromLTRB(15, 20, 0, 0),
                                        child: Text(
                                          LabelStr.lblGetReasonOther,
                                          style: AppTheme.boldSFTextStyle()
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: HexColor("#3d3d3d")),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: HexColor("#e9e9e9"),
                                    ),
                                    TextFormField(
                                      controller: reasonController,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        hintText: 'Broken arm',
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        reasonSelected();
                                        Utils.navigateToScreen(
                                            context,
                                            ClientPatientSignScreen(
                                                widget.completedNoteResponse,careTakerReason));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 30,
                                            right: 20,
                                            left: 20,
                                            bottom: 20),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              HexColor("#1785e9"),
                                              HexColor("#83cff2")
                                            ]),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: TextButton(
                                          child: Text(
                                              LabelStr.lblGetCaretakerSignature,
                                              style: AppTheme.boldSFTextStyle()
                                                  .copyWith(
                                                      fontSize: 20,
                                                      color: Colors.white)),
                                          onPressed: () {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            checkConnection()
                                                .then((isConnected) {
                                              reasonSelected();
                                              Utils.navigateToScreen(
                                                  context,
                                                  ClientPatientSignScreen(
                                                      widget.completedNoteResponse,careTakerReason));
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ]))));
      }),
    );
  }

  void reasonSelected() {
    if (widget.finalValue == SingingCharacter.Physical) {
      careTakerReason = "physical impairment";
      print(careTakerReason);
    } else if (widget.finalValue == SingingCharacter.mental) {
      careTakerReason = "mental impairment";
      print(careTakerReason);
    } else {
      careTakerReason = reasonController.text;
      print(careTakerReason);
    }
  }
}
