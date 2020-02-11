import "package:flutter/material.dart";

import "package:flutter_personal_expense_app/models/Transaction.dart";
import "package:flutter_personal_expense_app/models/DaySpendings.dart";
import 'package:intl/intl.dart';

import 'chart_item.dart';

class Chart extends StatelessWidget{
  Map<String, DaySpendings> _spendingsPerDay = Map();
  final dayShortcuts = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  Chart(List<Transaction> transactions) {
    var totalSpendings = 0.0;

    for (String day in dayShortcuts) {
      _spendingsPerDay[day] = DaySpendings(
          daySpendings: 0,
          dayShortcut: day,
          percentageOfAllSpendings: 0);
    }

    for (Transaction tx in transactions) {
      totalSpendings += double.parse(tx.amount);
      _spendingsPerDay[DateFormat.EEEE().format(tx.date).substring(0, 3)].daySpendings += double.parse(tx.amount);
    }

    _spendingsPerDay.values.forEach((daySpendings) {
      daySpendings.percentageOfAllSpendings = totalSpendings == 0.0 ? 0.0 : daySpendings.daySpendings / totalSpendings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _spendingsPerDay.values.map((daySpendings) {
              return Flexible(child: ChartItem(daySpendings));
            }).toList()
        ),
      )
    );
  }
}