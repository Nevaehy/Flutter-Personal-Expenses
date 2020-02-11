import "package:flutter/material.dart";

import "package:flutter_personal_expense_app/models/Transaction.dart";
import "./transaction_item.dart";


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
        ? Column(
            children: <Widget>[
              SizedBox(
                height: 10,
                ),
              Text("No transactions added yet"),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                child: Image.asset(
                  'assets/images/no_transaction.png',
                  fit: BoxFit.cover
                )
              )
            ],
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              return TransactionItem(
                transactions[index],
                removeTransaction
              );
            }
          )
    );
  }
}