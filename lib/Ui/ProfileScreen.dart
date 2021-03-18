import 'dart:async';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/PrefsUtils.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:evv_plus/GeneralUtils/Utils.dart';
import 'package:evv_plus/Models/AuthViewModel.dart';
import 'package:evv_plus/Models/CityListResponse.dart';
import 'package:evv_plus/Models/StateListResponse.dart';
import 'package:evv_plus/Models/UpdateNurseProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  AuthViewModel _nurseViewModel = AuthViewModel();
  UpdateNurseProfile updateNurseProfile;
  var email,
      addressLineOne,
      addressLineTwo,
      zipCode,
      phoneNumber,
      firstName,
      middleName,
      lastName,
      dateOfBirth,
      nurseImage;
  bool isLoading = true;
  String nurseId;
  List<StateData> stateList = [];
  List<CityData> cityList;
  String stateId;
  String cityId;
  String gender;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      PrefUtils.getNurseDataFromPref();
      nurseId = prefs.getInt(PrefUtils.nurseId).toString();
      email = prefs.getString(PrefUtils.email);
      addressLineOne = prefs.getString(PrefUtils.addressLineOne);
      addressLineTwo = prefs.getString(PrefUtils.addressLineTwo);
      zipCode = prefs.getString(PrefUtils.zipCode);
      phoneNumber = prefs.getString(PrefUtils.phoneNumber);
      firstName = prefs.getString(PrefUtils.firstName);
      middleName = prefs.getString(PrefUtils.MiddleName);
      lastName = prefs.getString(PrefUtils.lastName);
      gender = prefs.getString(PrefUtils.Gender);
      dateOfBirth = prefs.getString(PrefUtils.DateOfBirth);
      nurseImage = prefs.getString(PrefUtils.NurseImage);
      checkConnection().then((isConnected) {
        if (isConnected) {
          _getSateLIst();
          _getNurseProfileDetail(nurseId);
        } else {
          ToastUtils.showToast(context, LabelStr.connectionError, Colors.red);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    if (isLoading) {
      return Container(
        color: Colors.white,
      );
    } else {
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
                              child: Text("${firstName + " " + lastName}",
                                  style: AppTheme.boldSFTextStyle().copyWith(
                                      fontSize: 24, color: Colors.white)),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: Text("Columbis, ohio",
                                  style: AppTheme.regularSFTextStyle().copyWith(
                                      fontSize: 14, color: Colors.white)),
                            ),
                          ],
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                                gender.toUpperCase(),
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
                              email,
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
                              phoneNumber,
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
                            addressLineOne, _addressLineOneController,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.streetAddress)),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                        width: MediaQuery.of(context).size.width,
                        height: 65,
                        child: textFieldFor(
                            addressLineTwo, _addressLineTwoController,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.streetAddress)),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0,
                                  color: HexColor("#D2D2D2"),
                                  style: BorderStyle.solid),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 45,
                          child: new DropdownButton(
                            underline: SizedBox(),
                            isExpanded: true,
                            items: stateList.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.stateName),
                                value: item.stateId.toString(),
                              );
                            }).toList(),
                            onChanged: (newVal) {
                              setState(() {
                                stateId = newVal;
                                cityList.clear();
                                _getCityList(stateId);
                              });
                            },
                            value: stateId,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                              margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.0,
                                      color: HexColor("#D2D2D2"),
                                      style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                ),
                              ),
                              width: MediaQuery.of(context).size.width * 0.42,
                              height: 45,
                              child: cityList.length != 0
                                  ? DropdownButton(
                                      underline: SizedBox(),
                                      isExpanded: true,
                                      items: cityList.map((item) {
                                        return new DropdownMenuItem(
                                          child: new Text(item.cityName),
                                          value: item.cityId.toString(),
                                        );
                                      }).toList(),
                                      onChanged: (newVal) {
                                        setState(() {
                                          cityId = newVal;
                                        });
                                      },
                                      value: cityId,
                                    )
                                  : Center(
                                      child: Container(
                                      child: Text("Please select state first"),
                                    )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.fromLTRB(0, 5, 2, 0),
                              height: 65,
                              padding: EdgeInsets.fromLTRB(10, 5, 20, 0),
                              child: textFieldFor(zipCode, _zipController,
                                  autocorrect: false,
                                  maxLength: 6,
                                  keyboardType: TextInputType.number)),
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                        width: MediaQuery.of(context).size.width,
                        height: 65,
                        child: textFieldFor(phoneNumber, _phoneController,
                            keyboardType: TextInputType.number, maxLength: 10)),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            HexColor("#1785e9"),
                            HexColor("#83cff2")
                          ]),
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
  }

  void validationForCollectClientSignature() {
    if (_addressLineOneController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterAddressLineOne, Colors.red);
    } else if (_addressLineTwoController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterAddressLineTwo, Colors.red);
    } else if (stateId == null || stateList.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterState, Colors.red);
    } else if (cityId == null || cityList.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterCity, Colors.red);
    } else if (_zipController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterZip, Colors.red);
    } else if (_phoneController.text.isEmpty) {
      ToastUtils.showToast(context, LabelStr.enterPhoneNumber, Colors.red);
    } else {
      Utils.showLoader(true, context);
      _nurseViewModel.getUpdateProfileAPICall(
          nurseId,
          _addressLineOneController.text,
          _addressLineTwoController.text,
          _zipController.text,
          cityId,
          stateId,
          _phoneController.text,
          firstName,
          middleName,
          lastName,
          gender,
          dateOfBirth,
          email,
          nurseImage, (isSuccess, response) {
        Utils.showLoader(false, context);
        if (isSuccess) {
          setState(() {
            ToastUtils.showToast(
                context, "NurseProfile Updated Successfully.", Colors.green);
            Timer(
              Duration(milliseconds: 200),
              () => Navigator.of(context).pop(),
            );
          });
        } else {
          setState(() {});
        }
      });
    }
  }

  void _getNurseProfileDetail(String nurseId) {
    Utils.showLoader(true, context);
    _nurseViewModel.getProfileAPICall(nurseId, (isSuccess, response) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          isLoading = false;
          email = _nurseViewModel.nurseResponse.email;
          addressLineOne = _nurseViewModel.nurseResponse.address1;
          addressLineTwo = _nurseViewModel.nurseResponse.address2;
          zipCode = _nurseViewModel.nurseResponse.zipCode;
          phoneNumber = _nurseViewModel.nurseResponse.phoneNumber;
          gender = _nurseViewModel.nurseResponse.gender;
          _addressLineOneController.text = addressLineOne;
          _addressLineTwoController.text = addressLineTwo;
          _zipController.text = zipCode;
          _phoneController.text = phoneNumber;
          firstName = _nurseViewModel.nurseResponse.firstName;
          lastName = _nurseViewModel.nurseResponse.lastName;
        });
      } else {
        setState(() {});
      }
    });
  }

  void _getSateLIst() {
    Utils.showLoader(true, context);
    _nurseViewModel.getStateList((isSuccess, response) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          isLoading = false;
          stateList = [];
          stateList = _nurseViewModel.stateList;
          cityList = [];
        });
      } else {
        setState(() {});
      }
    });
  }

  void _getCityList(String stateId) {
    Utils.showLoader(true, context);
    _nurseViewModel.getCityList(stateId, (isSuccess, response) {
      Utils.showLoader(false, context);
      if (isSuccess) {
        setState(() {
          cityList = [];
          cityList = _nurseViewModel.cityDataList;
        });
      } else {
        setState(() {
          cityList = [];
        });
      }
    });
  }
}
