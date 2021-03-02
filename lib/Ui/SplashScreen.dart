import 'dart:async';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:flutter/material.dart';

import 'IntroScreen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
          () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => IntroScreen())),
    );
    //print("Splash Done!"))
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 200),
              Padding(padding: EdgeInsets.only(left: 30.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "EVV APP",
                    style: TextStyle(
                      fontSize: 45,
                      color: HexColor("#000000"),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              /*Padding(padding: EdgeInsets.only(top: 30.0, left: 30.0,),
                child: Align(alignment: Alignment.centerLeft,
                  child: Text(
                    "Set extact location to find the right\nrestaurants near you. ",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),*/
            ],
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
