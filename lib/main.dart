import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servers/bloc/server_bloc.dart';
import 'package:servers/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ServerBloc(),
      child: MaterialApp(
        title: 'Servers',
        theme: ThemeData(
            primaryColor: Color(0xFF00ABA6),
            accentColor: Colors.white,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Color(0XFF00ABA6),
            )),
        home: Home(),
      ),
    );
  }
}
