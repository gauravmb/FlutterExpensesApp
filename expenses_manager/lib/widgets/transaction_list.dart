import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransationList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteHandler;

  TransationList({required this.transactions, required this.deleteHandler});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text("No Transaction Available"),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: FittedBox(
                                child: Text(
                                    '\$${transactions[index].amount.toString()}'))),
                      ),
                      title: Text(transactions[index].title),
                      subtitle: Text(DateFormat.yMMMd().format(
                        transactions[index].date,
                      )),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          deleteHandler(transactions[index].id);
                        },
                      ),
                    ));
              },
            ),
    );
  }
}
