import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.removeTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function removeTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: FittedBox(
              child: Text('\$${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(transaction.title,
            style: Theme.of(context).textTheme.headline6),
        subtitle: Text(DateFormat.yMMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                onPressed: () => removeTransaction(transaction.id),
                textColor: Colors.red[900])
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => removeTransaction(transaction.id),
                color: Colors.red[900],
              ),
      ),
    );
  }
}
