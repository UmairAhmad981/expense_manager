import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  const TransactionList(this._transactions, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: _transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  "No Expense Found",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'asserts/images/notFound.png',
                    fit: BoxFit.fill,
                  ),
                )
              ],
            )
          : SizedBox(
              height: 400,
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: CircleAvatar(
                      child: Text("${_transactions[index].amount}"),
                    ),
                  );
                },
                itemCount: _transactions.length,
              ),
            ),
    );
  }
}
