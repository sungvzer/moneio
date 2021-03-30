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
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      widget1Opacity = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
            opacity: widget1Opacity,
            duration: Duration(seconds: 1),
            // TODO: Integrate with our "logo"
            child: FlutterLogo(
              size: 200,
              style: FlutterLogoStyle.markOnly,
            )),
      ),
    );
  }
}
