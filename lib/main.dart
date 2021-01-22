import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './widgets/chart.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              //button: TextStyle(color: Colors.)
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1',
        title: 'New Adidas Shoes',
        amount: 60.99,
        date: DateTime.now()),
    Transaction(
        id: 't2',
        title: 'Weekly Groceries',
        amount: 15.22,
        date: DateTime.now()),
  ];

  bool _showChart = true;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      {String newTitle, double newAmount, DateTime newDate}) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: newTitle,
        amount: newAmount,
        date: newDate);

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (modalContext) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  Widget buildMaterialNav(BuildContext context) {
    return AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );
  }

  Widget buildIOSNav(BuildContext context) {
    return CupertinoNavigationBar(
      middle: const Text('Personal Expenses'),
      trailing: CupertinoButton(
          child: const Icon(CupertinoIcons.add),
          padding: EdgeInsets.zero,
          onPressed: () => _startAddNewTransaction(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget currentAppBar =
        Platform.isIOS ? buildIOSNav(context) : buildMaterialNav(context);
    Widget transactionListWidget = Container(
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                currentAppBar.preferredSize.height) *
            0.75,
        child: TransactionList(_userTransactions, _removeTransaction));
    final Widget homeBodyWidget = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart',
                      style: Theme.of(context).textTheme.headline6),
                  Switch.adaptive(
                      value: _showChart,
                      activeColor: Theme.of(context).accentColor,
                      onChanged: (newValue) {
                        setState(() {
                          _showChart = newValue;
                        });
                      }),
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (mediaQuery.size.height -
                          mediaQuery.padding.top -
                          currentAppBar.preferredSize.height) *
                      0.25,
                  child: Chart(_recentTransactions)),
            if (!isLandscape) transactionListWidget,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              mediaQuery.padding.top -
                              currentAppBar.preferredSize.height) *
                          0.6,
                      child: Chart(_recentTransactions))
                  : transactionListWidget,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: homeBodyWidget,
            navigationBar: currentAppBar,
          )
        : Scaffold(
            appBar: currentAppBar,
            body: homeBodyWidget,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
