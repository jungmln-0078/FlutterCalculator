import 'package:calculator/model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatelessWidget {
  CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<CalculatorModel>(
      model: CalculatorModel(),
      child: ScopedModelDescendant<CalculatorModel>(
        builder: (context, child, model) => Scaffold(
          appBar: AppBar(
            title: Text("My Calculator"),
            centerTitle: true,
            elevation: 0.0,
          ),
          drawer: CalculatorHistory(),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    model.tempText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(
                    model.text,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Table(
                columnWidths: {
                  0: FlexColumnWidth(size),
                  1: FlexColumnWidth(size),
                  2: FlexColumnWidth(size),
                  3: FlexColumnWidth(size),
                },
                children: [
                  TableRow(
                    children: [
                      CalculatorButton(text: "CE", onClick: model.clear),
                      CalculatorButton(text: "C", onClick: model.clearAll),
                      CalculatorButton(text: "⌫", onClick: model.backSpace),
                      CalculatorButton(text: "÷", onClick: model.inputOperand),
                    ],
                  ),
                  TableRow(
                    children: [
                      CalculatorButton(text: "7", onClick: model.inputNumber),
                      CalculatorButton(text: "8", onClick: model.inputNumber),
                      CalculatorButton(text: "9", onClick: model.inputNumber),
                      CalculatorButton(text: "×", onClick: model.inputOperand),
                    ],
                  ),
                  TableRow(
                    children: [
                      CalculatorButton(text: "4", onClick: model.inputNumber),
                      CalculatorButton(text: "5", onClick: model.inputNumber),
                      CalculatorButton(text: "6", onClick: model.inputNumber),
                      CalculatorButton(text: "-", onClick: model.inputOperand),
                    ],
                  ),
                  TableRow(
                    children: [
                      CalculatorButton(text: "1", onClick: model.inputNumber),
                      CalculatorButton(text: "2", onClick: model.inputNumber),
                      CalculatorButton(text: "3", onClick: model.inputNumber),
                      CalculatorButton(text: "+", onClick: model.inputOperand),
                    ],
                  ),
                  TableRow(
                    children: [
                      CalculatorButton(
                          text: "+/-", onClick: model.togglePlusMinus),
                      CalculatorButton(text: "0", onClick: model.inputNumber),
                      CalculatorButton(text: ".", onClick: model.point),
                      CalculatorButton(text: "=", onClick: model.result),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorHistory extends StatelessWidget {
  CalculatorHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CalculatorModel model = CalculatorModel.of(context);
    return Drawer(
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
                  Text(
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
                        model.clearHistory();
                      },
                      child: Text(
                        "Clear History",
                        style: TextStyle(fontSize: 20, color: Colors.blue[900]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(5.0),
              itemCount: model.history.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      model.history[model.history.length - 1 - index],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  CalculatorButton({required this.text, required this.onClick, Key? key})
      : super(key: key);
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
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0))),
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
