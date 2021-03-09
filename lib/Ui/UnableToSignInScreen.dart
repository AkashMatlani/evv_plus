import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:flutter/material.dart';

class UnableToSignInScreen extends StatefulWidget {
  @override
  _unableToSignInScreenState createState() => _unableToSignInScreenState();
}

class _unableToSignInScreenState extends State<UnableToSignInScreen> {
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
                    Container(
                      color: Colors.white,
                      child: Container(
                        height: 300,
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor("#e9e9e9"),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Shani Bhavsar'),
                            Align(alignment:Alignment.center,child: Text("Sign Here")),
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
                  ]))));
        }));
  }
}
