import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteHandler;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: FittedBox(
                    child: Text('\$${transaction.amount.toString()}'))),
          ),
          title: Text(transaction.title),
          subtitle: Text(DateFormat.yMMMd().format(
            transaction.date,
          )),
          trailing: MediaQuery.of(context).size.width >= 460
              ? FlatButton.icon(
                  onPressed: () {
                    deleteHandler(transaction.id);
                  },
                  color: Theme.of(context).errorColor,
                  icon: Icon(Icons.delete),
                  label: Text("Delete"),
                )
              : IconButton(
                  icon: Icon(Icons.delete),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    deleteHandler(transaction.id);
                  },
                ),
        ));
  }
}
