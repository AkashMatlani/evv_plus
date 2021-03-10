import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { Physical, mental,other }

class UnableToSignInScreen extends StatefulWidget {
  @override
  _UnableToSignInScreenState createState() => _UnableToSignInScreenState();
}

class _UnableToSignInScreenState extends State<UnableToSignInScreen> {
  SingingCharacter _character = SingingCharacter.Physical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 120,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text(
            "Unable to Sign Reason",
            style: AppTheme.sfProLightTextStyle()
                .copyWith(fontSize: 24, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          // ...
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
                        Divider(height: 1),
                    Container(
                      padding: EdgeInsets.fromLTRB(20,30,20,0),
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
                                padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
                                child: Text(
                                  'Please Select a Reason',
                                  style: AppTheme.boldSFTextStyle().copyWith(
                                      fontSize: 16, color: HexColor("#3d3d3d")),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(
                              height: 1,
                              color: HexColor("#e9e9e9"),
                            ),

                            Column(
                              children: <Widget>[
                                ListTile(
                                  title:  Text('Physical Impairment',style: AppTheme.mediumSFTextStyle()
                                .copyWith(
                                fontSize: 14,
                                color: HexColor("#3d3d3d"))),
                                  leading: Radio(
                                    value: SingingCharacter.Physical,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title:  Text('Mental Impairment',style: AppTheme.mediumSFTextStyle()
                                      .copyWith(
                                      fontSize: 14,
                                      color: HexColor("#3d3d3d"))),
                                  leading: Radio(
                                    value: SingingCharacter.mental,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title:  Text('Other',
                                    style: AppTheme.mediumSFTextStyle()
                                        .copyWith(
                                      fontSize: 14,
                                      color: HexColor("#3d3d3d"))),
                                  leading: Radio(
                                    value: SingingCharacter.other,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter value) {
                                      setState(() {
                                        _character = value;
                                      });
                                    },
                                  ),
                                  minLeadingWidth : 2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  HexColor("#1785e9"),
                                  HexColor("#83cff2")
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: TextButton(
                              child: Text(LabelStr.lblSubmit,
                                  style: AppTheme.boldSFTextStyle().copyWith(
                                      fontSize: 18, color: Colors.white)),
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                checkConnection().then((isConnected) {});
                              },
                            ),
                          )),
                    ),
                  ]))));
        }));
  }
}
