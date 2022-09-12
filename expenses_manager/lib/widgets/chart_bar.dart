import 'package:expenses_manager/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageOfTotal;

  ChartBar({
    required this.label,
    required this.spendingAmount,
    required this.spendingPercentageOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    print("Build for Chart Bar");

    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
                child: Text(
              '\$${spendingAmount.toStringAsFixed(0)}',
            )),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.1,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(child: Text(label)),
          )
        ],
      );
    });
  }
}
