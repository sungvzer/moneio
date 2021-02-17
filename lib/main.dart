import 'package:flutter/material.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/views/application.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider<JsonBloc>(
    create: (context) => JsonBloc(),
    child: Application(),
  ));
}
