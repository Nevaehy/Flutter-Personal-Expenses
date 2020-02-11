import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget{
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        _selectedDate == null
                            ? "No date chosen"
                            : "Picked date: ${DateFormat.yMd().format(_selectedDate)}",
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _showDatePicker,
                    child: Text(
                      "Choose date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text("Add Transaction"),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
              onPressed: _submitData,
            )
          ],
        )
      )
    );
  }

  void _submitData() {
    final title = _titleController.text;
    String amount = _amountController.text;

    if (title.isEmpty || amount.isEmpty || _selectedDate == null)
      return;

    double nAmount = double.parse(amount);
    if (nAmount <= 0 )
      amount = "0.00";

    _amountController.text = (nAmount.toStringAsFixed(2));

    Navigator.of(context).pop();

    widget.addTransaction(
        _titleController.text,
        _amountController.text,
      _selectedDate
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now()
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }
}