import 'dart:async';

import 'package:evv_plus/Models/SliderModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';
import '../GeneralUtils/PageIndicator.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IntroScreen();
}

class _IntroScreen extends State<IntroScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalPages = SliderItem.loadSliderItem().length;
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: totalPages,
          itemBuilder: (BuildContext context, int index) {
            SliderModel si = SliderItem.loadSliderItem()[index];
            return Container(
              color: si.color,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < totalPages; i++)
                          if (i == _currentPage)
                            SlideDots(true)
                          else
                            SlideDots(false)
                      ],
                    ),
                  ),
                  Positioned(
                      top: 40,
                      right: -5,
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.2,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                ],
              ),
            );
          }),
    );
  }
}
