import 'package:flutter/material.dart';

import '../main.dart';

class CalculatorButton extends StatelessWidget {
  CalculatorButton({required this.text, required this.onClick, Key? key}) : super(key: key);
  final String text;
  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: Colors.white,
      child: Center(
        child: OutlinedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
            minimumSize: MaterialStateProperty.all(Size.fromHeight(size)),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () {
            if (onClick is Function(String)) {
              onClick(text);
            } else {
              onClick();
            }
          },
          child: Text(
            text,
            style: _buttonTextStyle(),
          ),
        ),
      ),
    );
  }

  TextStyle _buttonTextStyle() {
    return TextStyle(
      fontSize: 25,
      color: Colors.black,
    );
  }
}
