import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction yet',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 300,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover)),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (itemBuilderContext, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(transactions[index].title,
                              style: Theme.of(context).textTheme.headline6),
                          Text(
                            DateFormat.yMMMMd()
                                .format(transactions[index].date),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
