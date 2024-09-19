import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function btnPressed;

  const NewTransaction(this.btnPressed, {super.key});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleText = TextEditingController();

  final amt = TextEditingController();

  void addTxn() {
    final enteredText = titleText.text;

    if (enteredText.isEmpty || amt.text.isEmpty || _date == null) {
      return;
    }

    final String enteredAmt = double.parse(amt.text).toStringAsFixed(2);

    widget.btnPressed(
      enteredText,
      double.parse(enteredAmt),
      _date,
    );
    Navigator.pop(context);
  }

  DateTime? _date ;

  void pickDate() {
    showDatePicker(
      initialDate: DateTime.now(),
      context: context,
      firstDate: DateTime(
          DateTime.now().year, (DateTime.now().month) - 6, DateTime.now().day),
      lastDate: DateTime.now(),
    ).then((datePick) {
      if (datePick == null) {
        return;
      }
      setState(() {
        _date = datePick;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: titleText,
              onSubmitted: (_) => addTxn(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: amt,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addTxn(),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    child: _date == null
                        ? const Text("No Date Chosen!!!")
                        : Text('Date : ${DateFormat('EEE, MMM d').format(_date!)}')),
                TextButton(
                  onPressed: pickDate,
                  child: const Text("Choose Date"),
                )
              ],
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: OutlinedButton(
                onPressed: () => addTxn(),
                style: Theme.of(context).outlinedButtonTheme.style,
                child: const Text("Add Transaction"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
