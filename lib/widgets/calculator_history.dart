import 'package:calculator/models/model.dart';
import 'package:flutter/material.dart';

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
                      style: TextButton.styleFrom(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
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
