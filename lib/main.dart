import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_personal_expense_app/widgets/chart.dart';

import 'models/Transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        secondaryHeaderColor: Colors.purple,
        accentColor: Colors.deepOrangeAccent,
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          button: TextStyle(color: Colors.white),
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Expenses"),
        actions: <Widget>[
          if (Platform.isIOS)  _buildIOSContent()
        ],
      ),
      body: Column(
        children: <Widget>[
          Chart(
          _transactions
        ),
          TransactionList(
              _transactions,
              _removeTransaction
          ),
        ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isAndroid ? _buildAndroidContent() : Container(width: 0, height: 0)
    );
  }

  Widget _buildIOSContent() {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: () => _showAddNewTransaction(context)
    );
  }

  Widget _buildAndroidContent() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () => _showAddNewTransaction(context),
    );
  }

  void _showAddNewTransaction(BuildContext context) {
    showModalBottomSheet(context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        }
     );
  }

  void _addNewTransaction(String title, String amount, DateTime dateTime) {
    final transaction = Transaction(
      name: title,
      amount: amount,
      date: dateTime,
      id: DateTime.now().toString()
    );

    setState(() {
      _transactions.add(transaction);
    });
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((trans) => trans.id == id);
    });
  }
}
