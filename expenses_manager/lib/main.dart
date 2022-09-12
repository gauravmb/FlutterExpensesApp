import 'dart:io';
import 'package:expenses_manager/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'package:flutter/cupertino.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleLarge: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 40,
                  ),
                  titleMedium: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                  ),
                  titleSmall: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 10,
                  ))),
          fontFamily: "Quicksand",
          primarySwatch: Colors.green,
          accentColor: Colors.amber),
      home: const MyHomePage(title: 'Expenses Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [];
  bool showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void addTransaction(String title, double amount, DateTime txdate) {
    final tx = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        title: title,
        date: txdate);
    setState(() {
      _userTransaction.add(tx);
    });
  }

  void deleteTransaction(String Id) {
    setState(() {
      _userTransaction.removeWhere((element) => element.id == Id);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(
              newTXHandler: addTransaction,
            ),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print("Build for My Home Page State ");

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Personal Expences"),
            trailing: GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap: () => _startNewTransaction(context),
            ),
          )
        : AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(widget.title),
            actions: [
              IconButton(
                  onPressed: () => _startNewTransaction(context),
                  icon: Icon(Icons.add))
            ],
          ) as PreferredSizeWidget;
    final mediaQuery = MediaQuery.of(context);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methodsxs
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final txListTransaction = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransationList(
        transactions: _userTransaction,
        deleteHandler: deleteTransaction,
      ),
    );

    final txChart = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          (isLandscape ? 0.7 : 0.3),
      child: Chart(
        _recentTransactions,
      ),
    );

    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Show Chart",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Switch.adaptive(
                  value: showChart,
                  onChanged: (value) {
                    setState(() {
                      showChart = value;
                    });
                  },
                ),
              ],
            ),
          if (isLandscape) showChart ? txChart : txListTransaction,
          if (!isLandscape) txChart,
          if (!isLandscape) txListTransaction,
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startNewTransaction(context),
                  ),
          );
  }
}
