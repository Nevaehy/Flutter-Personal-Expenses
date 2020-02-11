import "package:flutter/material.dart";

import "package:flutter_personal_expense_app/models/Transaction.dart";
import "package:intl/intl.dart";

class TransactionItem extends StatelessWidget {
  final Transaction _transaction;
  final Function removeTransaction;

  TransactionItem(this._transaction, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: ListTile(
            leading: CircleAvatar(
              radius: 35,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text('\$${_transaction.amount}'),
                ),
              ),
            ), 
            title: Text(
                _transaction.name,
                style: Theme.of(context).textTheme.title
            ),
            subtitle: Text(
              DateFormat.yMMMd().format(_transaction.date),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () => removeTransaction(_transaction.id),
            )
        )
    );
  }
}