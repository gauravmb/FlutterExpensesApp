import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransationList extends StatelessWidget {
  final List<Transaction> transactions;
  Function deleteHandler;

  TransationList({required this.transactions, required this.deleteHandler});

  @override
  Widget build(BuildContext context) {
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
                      trailing: MediaQuery.of(context).size.width >= 460
                          ? FlatButton.icon(
                              onPressed: () {
                                deleteHandler(transactions[index].id);
                              },
                              color: Theme.of(context).errorColor,
                              icon: Icon(Icons.delete),
                              label: Text("Delete"),
                            )
                          : IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () {
                                deleteHandler(transactions[index].id);
                              },
                            ),
                    ));
              });
    });
  }
}
