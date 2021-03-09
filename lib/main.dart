
import 'package:evv_plus/Ui/NavigationDrawerScreen.dart';
import 'package:flutter/material.dart';

import 'Ui/SplashScreen.dart';

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
      home: NavigationDrawerScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

