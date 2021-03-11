
import 'package:evv_plus/Ui/DailyLivingTask.dart';
import 'package:evv_plus/Ui/ScheduleScreen.dart';
import 'package:evv_plus/Ui/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EVV Plus',
      theme: ThemeData(
          primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

