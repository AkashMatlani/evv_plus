import 'package:evv_plus/GeneralUtils/ColorExtension.dart';
import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:evv_plus/GeneralUtils/LabelStr.dart';
import 'package:evv_plus/GeneralUtils/ToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
              LabelStr.lblNotification,
              style: AppTheme.boldSFTextStyle()
                  .copyWith(fontSize: 26, color: Colors.black),
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
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: HexColor("#efefef"),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView.separated(
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            'Lorem ipsum dolor sit amet, consectetur adipisc.trttretertrtett',
                            style: AppTheme.semiBoldSFTextStyle().copyWith(
                                fontSize: 16, color: HexColor("#3d3d3d")),
                          )),
                          Container(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Text(
                                'Curabitur magna augue, rutrum non nisl…',
                                style: AppTheme.regularSFTextStyle().copyWith(
                                    fontSize: 14, color: HexColor("#838383")),
                                maxLines: 50,
                              )),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                  child: Text(
                                    '02 Feb 2021',
                                    style: AppTheme.mediumSFTextStyle()
                                        .copyWith(
                                            fontSize: 12,
                                            color: HexColor("#838383")),
                                  )),
                              Container(
                                height: 7,
                                width: 7,
                                margin: EdgeInsets.only(top: 13,left: 5),
                                child: SvgPicture.asset(MyImage.ic_fill_circle, color: HexColor("#228de9")),
                              ),
                              Container(
                                  padding: EdgeInsets.fromLTRB(5, 15, 0, 0),
                                  child: Text(
                                    '07:45 am',
                                    style: AppTheme.mediumSFTextStyle()
                                        .copyWith(
                                            fontSize: 12,
                                            color: HexColor("#838383")),
                                  )),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )); //
  }

  final Color textUnreadGreenColor = Color.fromARGB(255, 8, 211, 111);

  Widget buildUnreadMessages() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 5,
        width: 5,
        decoration: BoxDecoration(
          color: textUnreadGreenColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
