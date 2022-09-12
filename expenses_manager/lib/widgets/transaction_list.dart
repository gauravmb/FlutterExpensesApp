import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransationList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteHandler;

  TransationList({required this.transactions, required this.deleteHandler});

  @override
  Widget build(BuildContext context) {
    print("Build for TransationList ");

    return LayoutBuilder(builder: (context, constraints) {
      return transactions.isEmpty
          ? Column(
              children: [
                Container(
                  height: constraints.maxHeight * 0.15,
                  child: Text(
                    "No Transaction Available",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.75,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return TransactionItem(
                    transaction: transactions[index],
                    deleteHandler: deleteHandler);
              });
    });
  }
}
