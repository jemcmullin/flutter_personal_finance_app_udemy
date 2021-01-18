import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double percentSpentOfTotal;

  ChartBar(this.label, this.spentAmount, this.percentSpentOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text('\$${spentAmount.toStringAsFixed(0)}')),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[350],
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: percentSpentOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label.substring(0, 1)),
      ],
    );
  }
}
