import 'dart:async';

import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../GeneralUtils/ColorExtension.dart';
import '../GeneralUtils/Constant.dart';
import '../GeneralUtils/LabelStr.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _addressLineOneController = TextEditingController();
  var _addressLineTwoController = TextEditingController();
  var _cityController = TextEditingController();
  var _zipController = TextEditingController();
  var _phoneController = TextEditingController();

  final Widget svg = new SvgPicture.asset(MyImage.profileHeaderBgImage);
  MediaQueryData _mediaQueryData;
  double screenWidth;
  double screenHeight;
  double blockSizeHorizontal;
  double blockSizeVertical;
  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(MyImage.profileHeaderBgImage,
                          fit: BoxFit.fill),
                      Container(
                          child: Column(
                            children: [
                              SizedBox(height: 50),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Container(
                                      child: Icon(Icons.arrow_back,
                                          color: Colors.white),
                                      margin: EdgeInsets.only(left: 10),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 20),
                                    child: Text(LabelStr.lblMyProfile,
                                        style: AppTheme.boldSFTextStyle()
                                            .copyWith(
                                                fontSize: 24,
                                                color: Colors.white)),
                                  ))
                                ],
                              ),
                              SizedBox(height: 15),
                              Container(
                                  alignment: Alignment.center,
                                  child: SvgPicture.asset(
                                      MyImage.user_placeholder,
                                      height: 120,
                                      width: 120)),
                              SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Text("Katie Williamson",
                                    style: AppTheme.boldSFTextStyle().copyWith(
                                        fontSize: 24, color: Colors.white)),
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                alignment: Alignment.center,
                                child: Text("Columbis, ohio",
                                    style: AppTheme.regularSFTextStyle()
                                        .copyWith(
                                            fontSize: 14, color: Colors.white)),
                              ),
                            ],
                          ))
                    ],
                  ),
                  SizedBox(height: 30,),
                  IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                LabelStr.lblSsn.toUpperCase(),
                                style: AppTheme.semiBoldSFTextStyle()
                                    .copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "123-23-3434",
                                style: AppTheme.regularSFTextStyle().copyWith(
                                    fontSize: 16, color: Color(0xff868686)),
                              )
                            ],
                          ),
                          VerticalDivider(color: Color(0xff979797)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                LabelStr.lblDob.toUpperCase(),
                                style: AppTheme.semiBoldSFTextStyle()
                                    .copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "02/12/1990",
                                style: AppTheme.regularSFTextStyle().copyWith(
                                    fontSize: 16, color: Color(0xff868686)),
                              )
                            ],
                          ),
                          VerticalDivider(
                            color: Color(0xff979797),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                LabelStr.lblGender.toUpperCase(),
                                style: AppTheme.semiBoldSFTextStyle()
                                    .copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Female",
                                style: AppTheme.regularSFTextStyle().copyWith(
                                    fontSize: 16, color: Color(0xff868686)),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            LabelStr.lblEmail.toUpperCase(),
                            style: AppTheme.semiBoldSFTextStyle()
                                .copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "example123@gmail.com",
                            style: AppTheme.regularSFTextStyle().copyWith(
                                fontSize: 16, color: Color(0xff868686)),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            LabelStr.lblPhone.toUpperCase(),
                            style: AppTheme.semiBoldSFTextStyle()
                                .copyWith(fontSize: 14),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "+12 22222 55555",
                            style: AppTheme.regularSFTextStyle().copyWith(
                                fontSize: 16, color: Color(0xff868686)),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Divider(color: Color(0xff979797)),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: textFieldFor(
                          LabelStr.lblAddressLineOne, _addressLineOneController,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.streetAddress)),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: textFieldFor(
                          LabelStr.lblAddressLineTwo, _addressLineTwoController,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          keyboardType: TextInputType.streetAddress)),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.50,
                          padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                          height: 65,
                          child: textFieldFor(
                            LabelStr.lblCity,
                            _cityController,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: 65,
                          padding: EdgeInsets.fromLTRB(10, 5, 20, 0),
                          child: textFieldFor(LabelStr.lblZip, _zipController,
                              autocorrect: false,
                              maxLength: 6,
                              keyboardType: TextInputType.number)),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                      width: MediaQuery.of(context).size.width,
                      height: 65,
                      child: textFieldFor(LabelStr.lblPhone, _phoneController,
                          keyboardType: TextInputType.number,maxLength: 10)),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [HexColor("#1785e9"), HexColor("#83cff2")]),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextButton(
                      child: Text(LabelStr.lblUpdate,
                          style: AppTheme.mediumSFTextStyle()
                              .copyWith(fontSize: 18, color: Colors.white)),
                      onPressed: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        checkConnection().then((isConnected) {
                          validationForCollectClientSignature();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0, size.height * 0.85); //vertical line
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height * 0.85); //quadratic curve
    path.lineTo(size.width, 0); //vertical line
    return path;
  }

  void validationForCollectClientSignature() {
    if (_addressLineOneController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterAddressLineOne, Colors.red);
    } else if (_addressLineTwoController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterAddressLineTwo, Colors.red);
    } else if (_cityController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterCity, Colors.red);
    } else if (_zipController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterZip, Colors.red);
    } else if (_phoneController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterPhoneNumber, Colors.red);
    } else {
      Timer(
        Duration(milliseconds: 200),
        () => Navigator.of(context).pop(),
      );
    }
  }
}

// CustomPainter class to for the header curved-container
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xff1785e9);
    Paint paint1 = Paint()..color = Color(0xff83cff2);
    Path path = new Path();
    path.lineTo(0, size.height * 0.85);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.85);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint1);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
