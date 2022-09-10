import 'package:expenses_manager/models/transaction.dart';
import 'package:expenses_manager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart({required this.recentTransactions});

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum = recentTransactions[i].amount + totalSum;
        }
      }
      debugPrint("Total Sum");
      debugPrint(totalSum.toString());
      return {'Day': DateFormat.E().format(weekDay), 'Amount': totalSum};
    }).reversed.toList();
  }

  double get totalOfAmountOfAllRecentTransactions {
    return groupTransactionValues.fold(
      0.0,
      (sum, item) {
        return sum + (item['Amount'] as double);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(groupTransactionValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupTransactionValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['Day'].toString(),
                    spendingAmount: double.parse(data['Amount'].toString()),
                    spendingPercentageOfTotal:
                        totalOfAmountOfAllRecentTransactions == 0.0
                            ? 0.0
                            : double.parse(data['Amount'].toString()) /
                                totalOfAmountOfAllRecentTransactions,
                  ),
                );
              }).toList()),
        ));
  }
}
