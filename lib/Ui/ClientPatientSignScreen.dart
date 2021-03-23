import 'dart:convert';
import 'dart:io';

import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hand_signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'VerificationMenuScreen.dart';
import 'dart:ui' as ui;

class ClientPatientSignScreen extends StatefulWidget {
  @override
  _ClientPatientSignatureScreenState createState() =>
      _ClientPatientSignatureScreenState();
}

class _ClientPatientSignatureScreenState
    extends State<ClientPatientSignScreen> {

  HandSignatureControl control = new HandSignatureControl(
    threshold: 5.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );
  var pngBytes;
  var image;
  String path;
  var  directoryName = 'Evv';
  File signfile;
  String signSSPath;
  String signSSName;
  String fullSignPath;
  File newImage;
  String base64Image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0.0,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            centerTitle: true,
            title: Container(
              child: Text(
                LabelStr.lblclientSignature,
                style: AppTheme.boldSFTextStyle().copyWith(fontSize: 24),
              ),
            ),
            actions: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 10),
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
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                })),
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
                   /* Container(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 60),
                            Expanded(
                              child: Container(
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text('Shani Bhavsar',
                                        style: AppTheme.boldSFTextStyle()
                                            .copyWith(
                                                fontSize: 30,
                                                color: HexColor("#000000")))),
                              ),
                            ),
                            Expanded(
                                child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    LabelStr.lblSignHere,
                                    style: AppTheme.regularSFTextStyle()
                                        .copyWith(
                                            fontSize: 18,
                                            color: HexColor("#000000")),
                                  )),
                            )),
                          ],
                        ),
                      ),
                    ),*/
                        Center(
                          child: AspectRatio(
                            aspectRatio: 1.5,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height: 400,
                                  width: 400,
                            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                            color: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: HexColor("#e9e9e9"),
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    constraints: BoxConstraints.expand(),
                                    child: HandSignaturePainterView(
                                      control: control,
                                      type: SignatureDrawType.shape,
                                    ),
                                  ),
                                ),
                                CustomPaint(
                                  painter: DebugSignaturePainterCP(
                                    control: control,
                                    cp: false,
                                    cpStart: false,
                                    cpEnd: false,
                                  ),
                                ),
                           /*     control==null?Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                          padding: EdgeInsets.only(bottom: 20),
                                          child: Text(
                                            LabelStr.lblSignHere,
                                            style: AppTheme.regularSFTextStyle()
                                                .copyWith(
                                                fontSize: 18,
                                                color: HexColor("#000000")),
                                          )),
                                    )):Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(child:Text(""))))*/
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height*0.10,
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: control.clear,
                            child: Text('Clear',style: AppTheme.boldSFTextStyle().copyWith(
                              fontSize: 18, color: Colors.white,)),
                          ),
                        ),
                    Expanded(
                      flex: 1,
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
                            child: TextButton(
                              child: Text(LabelStr.lblSubmit,
                                  style: AppTheme.boldSFTextStyle().copyWith(
                                      fontSize: 18, color: Colors.white)),
                              onPressed: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                checkConnection().then((isConnected) {
                                  showImage(context);
                                  Utils.navigateToScreen(
                                      context, VerificationMenuScreen());
                                });
                              },
                            ),
                          )),
                    ),
                  ]))));
        }));
  }


 /* requestPermission() async {
    PermissionStatus result = await SimplePermissions.requestPermission(_permission);
    return result;
  }

  checkPermission() async {
    bool result = await SimplePermissions.checkPermission(_permission);
    return result;
  }*/

  String formattedDate() {
    DateTime dateTime = DateTime.now();
    String dateTimeString = 'Evv_' +
        dateTime.year.toString() +
        dateTime.month.toString() +
        dateTime.day.toString() +
        dateTime.hour.toString() +
        ':' + dateTime.minute.toString() +
        ':' + dateTime.second.toString() +
        ':' + dateTime.millisecond.toString() +
        ':' + dateTime.microsecond.toString();
    return dateTimeString;
  }

  Future<Null> showImage(BuildContext context) async {


    //pngBytes = await image.toByteData(format: ui.ImageByteFormat.png);

   // if(!(await checkPermission())) await requestPermission();

    // Use plugin [path_provider] to export image to storage
    Directory directory = await getExternalStorageDirectory();
    path = directory.path; //+ "/com.example.jobpostproduct";
  //  newImage = await image('$path/dummysign.png');

    print(path);
    await Directory('$path/$directoryName').create(recursive: true);
    //signfile = File('$path/$directoryName/${formattedDate()}.png');//.writeAsBytesSync(pngBytes.buffer.asInt8List());
    //signfile.writeAsBytesSync(pngBytes.buffer.asInt8List());
    signSSPath = "$path/$directoryName/";
    signSSName = "${formattedDate()}.png";
    fullSignPath = signSSPath+signSSName;
    newImage = File('$fullSignPath');
    newImage.writeAsBytesSync(pngBytes.buffer.asInt8List());
    //newImage.readAsBytesSync();
    List<int> imageBytes = newImage.readAsBytesSync();
    //newImage = await image.copy('$fullSignPath');

    //  final _imageFile = ImageProcess.decodeImage(
    //   newImage.readAsBytesSync(),
    //  );

    base64Image = base64Encode(imageBytes);
    print(base64Image);

  }
}
