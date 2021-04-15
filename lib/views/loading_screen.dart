import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = "/loading";

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double widget1Opacity = 0.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          curve: Curves.easeInOutCirc,
          size: 200,
          style: FlutterLogoStyle.horizontal,
        ),
      ),
    );
  }
}
