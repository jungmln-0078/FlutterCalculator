import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const double size = 80;
const String divideByZero = "Divide by zero";

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: const Calculator(),
    );
  }
}

class CalculatorState extends State<Calculator> {
  String _text = "0";
  String _tempText = "";
  List<String> _list = [];
  List<String> _history = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Calculator"),
        centerTitle: true,
        elevation: 0.0,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.menu),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 140,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[400],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      "History",
                      style: TextStyle(
                        fontSize: 40,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        onPressed: () {
                          _clearHistory();
                        },
                        child: Text(
                          "Clear History",
                          style:
                              TextStyle(fontSize: 20, color: Colors.blue[900]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _historyList(),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text(
                _tempText,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text(
                _text,
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(size),
              1: FlexColumnWidth(size),
              2: FlexColumnWidth(size),
              3: FlexColumnWidth(size),
            },
            children: [
              TableRow(
                children: [
                  _calculatorButton("CE", () {
                    _clear();
                  }),
                  _calculatorButton("C", () {
                    _clearAll();
                  }),
                  _calculatorButton("⌫", () {
                    _backSpace();
                  }),
                  _calculatorButton("÷", () {
                    _inputOperand("÷");
                  }),
                ],
              ),
              TableRow(
                children: [
                  _calculatorButton("7", () {
                    _inputNumber("7");
                  }),
                  _calculatorButton("8", () {
                    _inputNumber("8");
                  }),
                  _calculatorButton("9", () {
                    _inputNumber("9");
                  }),
                  _calculatorButton("×", () {
                    _inputOperand("×");
                  }),
                ],
              ),
              TableRow(
                children: [
                  _calculatorButton("4", () {
                    _inputNumber("4");
                  }),
                  _calculatorButton("5", () {
                    _inputNumber("5");
                  }),
                  _calculatorButton("6", () {
                    _inputNumber("6");
                  }),
                  _calculatorButton("-", () {
                    _inputOperand("-");
                  }),
                ],
              ),
              TableRow(
                children: [
                  _calculatorButton("1", () {
                    _inputNumber("1");
                  }),
                  _calculatorButton("2", () {
                    _inputNumber("2");
                  }),
                  _calculatorButton("3", () {
                    _inputNumber("3");
                  }),
                  _calculatorButton("+", () {
                    _inputOperand("+");
                  }),
                ],
              ),
              TableRow(
                children: [
                  _calculatorButton("+/-", () {
                    _togglePlusMinus();
                  }),
                  _calculatorButton("0", () {
                    _inputNumber("0");
                  }),
                  _calculatorButton(".", () {
                    _point();
                  }),
                  _calculatorButton("=", () {
                    _result();
                  }),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void _inputNumber(String n) {
    setState(() {
      if (_text == divideByZero) {
        _clearAll();
        return;
      }
      if (_text == "0") {
        _text = n;
      } else {
        _text += n;
      }
    });
  }

  void _inputOperand(String n) {
    setState(() {
      if (_text == divideByZero) {
        _clearAll();
        return;
      }
      if (_list.isEmpty) {
        _list.add(_text);
        _list.add(n);
        _tempText = "$_text $n";
        _text = "0";
      } else {
        _result();
      }
    });
  }

  void _togglePlusMinus() {
    setState(() {
      if (_text == divideByZero) {
        _clearAll();
        return;
      }
      if (_text == "0") return;
      if (_text.contains("-")) {
        _text = _text.replaceFirst("-", "");
      } else {
        _text = "-$_text";
      }
    });
  }

  void _point() {
    setState(() {
      if (_text == divideByZero) {
        _clearAll();
        return;
      }
      if (_text.contains(".")) return;
      _text += ".";
    });
  }

  void _clear() {
    setState(() {
      _list = [];
      _text = "0";
    });
  }

  void _clearAll() {
    _clear();
    setState(() {
      _tempText = "";
    });
  }

  void _backSpace() {
    setState(() {
      if (_text == divideByZero) {
        _clearAll();
        return;
      }
      if (_text.length > 1) {
        _text = _text.substring(0, _text.length - 1);
      } else {
        _text = "0";
      }
    });
  }

  void _result() {
    setState(() {
      if (_text == divideByZero) {
        _clearAll();
        return;
      }
      if (_list.length < 2) {
        _text = _text;
      } else {
        _list.add(_text);
        _text = _calculate(
            double.parse(_list[0]), _list[1], double.parse(_list[2]));
        _history.add("${_list.map((d) {
          try {
            return _parseDoubleToInt(double.parse(d));
          } catch (e) {
            return d;
          }
        }).join(" ")} = $_text");
        _list = [];
        _tempText = "";
      }
    });
  }

  String _calculate(double a, String operator, double b) {
    switch (operator) {
      case "+":
        return _parseDoubleToInt(a + b).toString();
      case "-":
        return _parseDoubleToInt(a - b).toString();
      case "×":
        return _parseDoubleToInt(a * b).toString();
      case "÷":
        if (b == 0) return divideByZero;
        return _parseDoubleToInt(a / b).toString();
    }
    return "";
  }

  num _parseDoubleToInt(double d) {
    bool t = d - d.toInt() != 0;
    return t ? d : d.floor();
  }

  void _clearHistory() {
    setState(() {
      _history = [];
    });
  }

  TextStyle _buttonTextStyle() {
    return const TextStyle(
      fontSize: 25,
      color: Colors.black,
    );
  }

  Container _calculatorButton(String text, VoidCallback callback) {
    return Container(
      width: size,
      height: size,
      color: Colors.white,
      child: Center(
        child: OutlinedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.grey[200]),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0))),
              minimumSize:
                  MaterialStateProperty.all(const Size.fromHeight(size)),
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap),
          onPressed: () {
            callback();
          },
          child: Text(
            text,
            style: _buttonTextStyle(),
          ),
        ),
      ),
    );
  }

  Widget _historyList() {
    return ListView.separated(
      padding: const EdgeInsets.all(5.0),
      itemCount: _history.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              _history[_history.length - 1 - index],
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  CalculatorState createState() => CalculatorState();
}
