import 'package:calculator/screens/calculator_app.dart';
import 'package:flutter/material.dart';

void main() => runApp(App());

const double size = 80;

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Calculator",
      theme: ThemeData(
        fontFamily: "Rubik",
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[400],
          foregroundColor: Colors.black,
        ),
      ),
      builder: (context, widget) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
      home: SafeArea(
        child: CalculatorApp(),
      ),
    );
  }
}
