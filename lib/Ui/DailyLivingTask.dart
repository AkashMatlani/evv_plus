import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/HelperWidgets.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DailyLivingTask extends StatefulWidget {
  @override
  _DailyLivingTaskState createState() => _DailyLivingTaskState();
}

class _DailyLivingTaskState extends State<DailyLivingTask> {

  var _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 100,
          title: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(right: 30),
            child: Text(LabelStr.lblDailyLivingTask, style: AppTheme.mediumSFTextStyle().copyWith(fontSize: 22)),
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
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, position) {
            return _listViewItems(context, position);
          },
        ),
      ),
    );
  }

  _listViewItems(BuildContext context, int position){
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: HexColor("#e9e9e9"), width: 1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text("Did you completed the task?", style: AppTheme.regularSFTextStyle().copyWith(color: HexColor("#3d3d3d"))),
                ),
                SizedBox(width: 10),
                Card(
                  margin: EdgeInsets.only(right: 10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Container(
                    padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
                    child: SvgPicture.asset(MyImage.ic_up_arrow),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width,
            color: HexColor("#e9e9e9"),
          ),
          Container(
            padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _radioGroup(),
                SizedBox(height: 5),
                multilineTextFieldFor(
                    "Comment here...",
                    _commentController,
                    100.0
                ),
                SizedBox(height: 10),
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        HexColor("#1785e9"),
                        HexColor("#83cff2")
                      ]),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: FlatButton(
                    child: Text(LabelStr.lblSubmit,
                        style: AppTheme.mediumSFTextStyle().copyWith(fontSize:18, color: Colors.white)),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      checkConnection().then((isConnected) {
                        if (isConnected) {
                          ToastUtils.showToast(context,
                              "Click on submit", Colors.red);
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
        ],
      ),
    );
  }
}

class _radioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class RadioGroupWidget extends State {

  String radioButtonItem = 'Yes';
  int id = 1;

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Radio(
              value: 1,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'Yes';
                  id = 1;
                });
              },
            ),
            Text(
              'Yes',
              style: new TextStyle(fontSize: 17.0),
            ),

            Radio(
              value: 2,
              groupValue: id,
              onChanged: (val) {
                setState(() {
                  radioButtonItem = 'No';
                  id = 2;
                });
              },
            ),
            Text(
              'No',
              style: new TextStyle(
                fontSize: 17.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}