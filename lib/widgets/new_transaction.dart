import 'package:flutter/material.dart';

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

    if (enteredText.isEmpty || amt.text.isEmpty) {
      return;
    }

    final String enteredAmt = double.parse(amt.text).toStringAsFixed(2);

    widget.btnPressed(
      enteredText,
      double.parse(enteredAmt),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
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
