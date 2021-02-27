import 'package:flutter/material.dart';

Size screenSize(BuildContext context) => MediaQuery.of(context).size;
Size percentSize(BuildContext context) => screenSize(context) / 100;
double screenHeight(BuildContext context) => screenSize(context).height;
double screenWidth(BuildContext context) => screenSize(context).width;
double percentHeight(BuildContext context) => screenHeight(context) / 100;
double percentWidth(BuildContext context) => screenWidth(context) / 100;
