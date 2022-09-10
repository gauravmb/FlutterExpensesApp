import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTXHandler;
  NewTransaction({required this.newTXHandler});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  var _selectedDate = null;

  void _submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.newTXHandler(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {}
      setState(() {
        _selectedDate = pickedDate as DateTime;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                // onChanged: (value) {
                //   titleInput = value;
                // },
                onSubmitted: (_) => _submitData,
                controller: titleController,
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: "Amount",
                ),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              Container(
                height: 70,
                child: Row(children: [
                  (_selectedDate != null
                      ? Text(DateFormat.yMMMd().format(_selectedDate))
                      : Text("No Date Choosen")),
                  FlatButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                  )
                ]),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: _submitData,
                child: Text("Add Transaction"),
              )
            ],
          ),
        ));
  }
}
