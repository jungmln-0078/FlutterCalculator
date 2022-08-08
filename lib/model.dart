import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

const String divideByZero = "Divide by zero";

class CalculatorModel extends Model {
  String _text = "0";

  get text => _text;

  String _tempText = "";

  get tempText => _tempText;

  List<String> _list = [];

  get list => _list;

  List<String> _history = [];

  get history => _history;

  static CalculatorModel of(BuildContext context) => ScopedModel.of(context, rebuildOnChange: true);

  void inputNumber(String n) {
    if (_text == divideByZero) {
      clearAll();
      return;
    }
    if (_text == "0") {
      _text = n;
    } else {
      _text += n;
    }
    notifyListeners();
  }

  void inputOperand(String n) {
    if (_text == divideByZero) {
      clearAll();
      return;
    }
    if (_list.isEmpty) {
      _list.add(_text);
      _list.add(n);
      _tempText = "$_text $n";
      _text = "0";
    } else {
      result();
    }
    notifyListeners();
  }

  void togglePlusMinus() {
    if (_text == divideByZero) {
      clearAll();
      return;
    }
    if (_text == "0") return;
    if (_text.contains("-")) {
      _text = _text.replaceFirst("-", "");
    } else {
      _text = "-$_text";
    }
    notifyListeners();
  }

  void point() {
    if (_text == divideByZero) {
      clearAll();
      return;
    }
    if (_text.contains(".")) return;
    _text += ".";
    notifyListeners();
  }

  void clear() {
    _text = "0";
    notifyListeners();
  }

  void clearAll() {
    clear();
    _list = [];
    _tempText = "";
    notifyListeners();
  }

  void backSpace() {
    if (_text == divideByZero) {
      clearAll();
      return;
    }
    if (_text.length > 1) {
      _text = _text.substring(0, _text.length - 1);
    } else {
      _text = "0";
    }
    notifyListeners();
  }

  void result() {
    if (_text == divideByZero) {
      clearAll();
      return;
    }
    if (_list.length < 2) {
      _text = _text;
    } else {
      _list.add(_text);
      _text =
          calculate(double.parse(_list[0]), _list[1], double.parse(_list[2]));
      _history.add("${_list.map((d) {
        try {
          return parseDoubleToInt(double.parse(d));
        } catch (e) {
          return d;
        }
      }).join(" ")} = $_text");
      _list = [];
      _tempText = "";
    }
    notifyListeners();
  }

  String calculate(double a, String operator, double b) {
    switch (operator) {
      case "+":
        return parseDoubleToInt(a + b).toString();
      case "-":
        return parseDoubleToInt(a - b).toString();
      case "×":
        return parseDoubleToInt(a * b).toString();
      case "÷":
        if (b == 0) return divideByZero;
        return parseDoubleToInt(a / b).toString();
    }
    return "";
  }

  num parseDoubleToInt(double d) {
    bool t = d - d.toInt() != 0;
    return t ? d : d.floor();
  }

  void clearHistory() {
    _history = [];
    notifyListeners();
  }
}
