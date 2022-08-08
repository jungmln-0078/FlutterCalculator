import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';
import '../models/model.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_history.dart';

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
                      CalculatorButton(text: "+/-", onClick: model.togglePlusMinus),
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
