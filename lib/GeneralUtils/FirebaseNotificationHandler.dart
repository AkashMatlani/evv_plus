import 'dart:convert';
import 'dart:io';

import 'package:evv_plus/GeneralUtils/Constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class FirebaseNotificationHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  BuildContext context;

  static const platform = const MethodChannel('com.app.EVVPLUS/configuration');

  FirebaseNotificationHandler(BuildContext context) {
    this.context = context;
  }

  void dispose() {
    flutterLocalNotificationsPlugin.cancelAll();
    flutterLocalNotificationsPlugin = null;
  }

  Function callback;

  fireBaseInitialization(Function callback) async {
    this.callback = callback;
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("Notification" + message.toString());
      if (Platform.isAndroid) {
        var title = message["notification"]["title"];
        var detail = message["notification"]["body"];
        Map<String, String> map = { "title": title ,"detail": detail};
        String result = await platform.invokeMethod('notification', map);
        print("Invoke result" + result);
      }
      showLocalAlert(message);

    }, onLaunch: (Map<String, dynamic> message) async {
      Future.delayed(Duration(milliseconds: 500)).then((v) {
        handleNotification(message);
      });
    }, onResume: (Map<String, dynamic> message) async {
      print("Resumed");
      Future.delayed(Duration(milliseconds: 500)).then((v) {
        handleNotification(message);
      });
    });

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  handleNotification(dynamic payload) {
    print("Firebase ::"+payload);
    String data = payload["notification"];
    callback(data);
  }

  void showLocalAlert(Map<String, dynamic> message) {
    var title;
    var detail;
    if (Platform.isIOS) {
      title = message["aps"]["alert"]["title"];
      detail = message["aps"]["alert"]["body"];
    } else {
      title = message["notification"]["title"];
      detail = message["notification"]["body"];
    }

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.all(
                  Radius.circular(10.0))),
          content: Builder(
            builder: (context) {
              // Get available height and width of the build area of this widget. Make a choice depending on the size.
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width-30,
                      alignment: Alignment.topLeft,
                      child: Text(
                        detail,
                        style: AppTheme.regularSFTextStyle().copyWith(fontSize: 15, color: Colors.black87),
                      ),
                    ),
                    SizedBox(height: 30),
                    InkWell(
                      onTap: (){
                        Navigator.of(context, rootNavigator: true).pop('dialog');
                      },
                      child: Container(
                        width: 100,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: TextButton(
                          onPressed: (){print('OK pressed');},
                          child: Text("OK", style: AppTheme.semiBoldSFTextStyle().copyWith(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        )
    );
  }

  showNotifications(Map<dynamic, dynamic> payload) async {
    print("show notificationcallled");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id',
        'your channel name',
        'your channel description',
        importance: Importance.Max,
        priority: Priority.High,
        icon: 'ic_default_notification',
        ticker: 'ticker');

    var iOSPlatformChannelSpecifics = IOSNotificationDetails(presentAlert: true);
    var platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    var data = payload['data'];
    await flutterLocalNotificationsPlugin.show(
        1, "EVVPLUS",
        payload['notification']['body'],
        platformChannelSpecifics,
        payload: json.encode(data));
  }

  /*void initLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
          print('notification title: $title');
        });
    var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            debugPrint('notification payload: $payload');
          };
        });
  }*/
}
