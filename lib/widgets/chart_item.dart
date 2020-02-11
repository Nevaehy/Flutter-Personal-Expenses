import "package:flutter/material.dart";
import 'package:flutter_personal_expense_app/models/DaySpendings.dart';

class ChartItem extends StatelessWidget {
  final DaySpendings daySpendings;

  ChartItem(this.daySpendings);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 16,
          child: FittedBox(
            child: Text("\$${daySpendings.daySpendings.toStringAsFixed(0)}")
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
              FractionallySizedBox(
                heightFactor: daySpendings.percentageOfAllSpendings,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                )
              )
           ]
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(daySpendings.dayShortcut),
      ]
    );
  }
}