import 'package:flutter/material.dart';

import './transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  TransactionList(this.transactions, this.removeTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    'No transaction yet',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover)),
                ],
              );
            })
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (itemBuilderContext, index) {
                return TransactionItem(
                    transaction: transactions[index],
                    removeTransaction: removeTransaction);
              },
            ),
    );
  }
}
