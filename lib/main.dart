import 'package:expense_manager/widgets/transaction_list.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import 'models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Manager',
      theme: ThemeData(
        fontFamily: 'Baloo Bhai 2',
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            primary: Colors.purple,
            secondary: Colors.yellowAccent),
        appBarTheme: const AppBarTheme(
          color: Colors.purple,
          titleTextStyle: TextStyle(
            fontFamily: 'Baloo Bhai 2', // Using offline font
            fontSize: 24, // Custom font size
            fontWeight: FontWeight.bold, // Bold text
            color: Colors.white, // Text color
          ),
        ),
        primaryTextTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.purple),
            foregroundColor: Colors.purple,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  void _addTransaction(String txTitle, double txAmt ,DateTime setDate) {
    final data = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmt,
      date: setDate,
    );
    setState(() {
      _transactions.add(data);
    });
  }

  void bottomAddTransScreen(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addTransaction);
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    },).toList();
  }

  void _deleteItemsList(String id){
    setState(() {
    _transactions.removeWhere((idx) => idx.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Manager',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: <Widget>[
          Chart(_recentTransactions),
          SizedBox(
            width: double.infinity,
            child: Card(
              elevation: 5,
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                "Graphs",
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
            ),
          ),
          TransactionList(_transactions,_deleteItemsList)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bottomAddTransScreen(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}