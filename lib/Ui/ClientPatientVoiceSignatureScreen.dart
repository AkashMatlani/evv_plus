import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ClientPatientVoiceSignatureScreen extends StatefulWidget {
  @override
  _ClientPatientVoiceSignatureScreenState createState() =>
      _ClientPatientVoiceSignatureScreenState();
}

class _ClientPatientVoiceSignatureScreenState
    extends State<ClientPatientVoiceSignatureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          centerTitle: true,
          title: Text(
            LabelStr.lblclientSignature,
            style: AppTheme.boldSFTextStyle()
                .copyWith(fontSize: 26, color: Colors.black),
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Center(
                child: Text(LabelStr.lblDone,
                    style: AppTheme.boldSFTextStyle().copyWith(
                      fontSize: 20,
                      color: HexColor("#1a87e9"),
                    )),
              ),
            )
          ],
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
                child: Column(
                  children: <Widget>[
                    Divider(
                      height: 2,
                      thickness: 1,
                      color: Color(0xff979797),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SvgPicture.asset(MyImage.mic_icon, height: 120, width: 120),
                    SizedBox(
                      height: 10,
                    ),
                    SvgPicture.asset(MyImage.equalizer_icon,
                        height: 120, width: 120),
                    SizedBox(
                      height: 30,
                    ),
                    Text(LabelStr.lblRecording,
                        style: AppTheme.regularSFTextStyle().copyWith(
                          fontSize: 20,
                          color: HexColor("#000000"),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text("00:10:00",
                        style: AppTheme.boldSFTextStyle().copyWith(
                          fontSize: 26,
                          color: HexColor("#3d3d3d"),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "This will take 10 second voice recording and will be\n saved once click on done",
                      textAlign: TextAlign.center,
                      style: AppTheme.regularSFTextStyle().copyWith(
                        fontSize: 16,
                        color: HexColor("#000000"),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SvgPicture.asset(MyImage.play_icon, height: 68, width: 68),
                    Expanded(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.all(20),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  HexColor("#1785e9"),
                                  HexColor("#83cff2")
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: FlatButton(
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
                  ],
                ),
              ),
            ),
          );
        }));
  }
}
