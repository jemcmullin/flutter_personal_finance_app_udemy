import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _chosenDate;

  void _submitTransaction() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final submitTitle = _titleController.text;
    final submitAmount = double.parse(_amountController.text);
    final submitDate = _chosenDate;

    if (submitTitle.isEmpty || submitAmount <= 0 || _chosenDate == null) {
      return;
    }

    widget.addTransaction(
        newTitle: submitTitle, newAmount: submitAmount, newDate: submitDate);

    Navigator.of(context).pop();
  }

  void _presentDataPicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 90)),
            lastDate: DateTime.now())
        .then((newDate) {
      if (newDate == null) {
        return;
      }
      setState(() {
        _chosenDate = newDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitTransaction(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitTransaction(),
              ),
              Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_chosenDate == null
                        ? 'Month DD, Year'
                        : 'Chosen Date: ${DateFormat.yMMMMd().format(_chosenDate)}'),
                    AdaptiveFlatButton('Choose Date', _presentDataPicker),
                  ],
                ),
              ),
              Platform.isIOS
                  ? CupertinoButton.filled(
                      child: Text('Add Transaction'),
                      onPressed: _submitTransaction,
                      padding: EdgeInsets.all(12),
                    )
                  : RaisedButton(
                      child: Text(
                        'Add Transaction',
                      ),
                      color: Theme.of(context).buttonColor,
                      textColor: Theme.of(context).textTheme.button.color,
                      onPressed: _submitTransaction,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
