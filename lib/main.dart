import 'package:bpc_flutter_test/pages/login_page.dart';
import 'package:bpc_flutter_test/pages/transaction_list_page.dart';
import 'package:bpc_flutter_test/pages/transaction_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter E-Commerce',
      routes: {
        '/login': (BuildContext context) => LoginPage(),
        '/transactions': (BuildContext context) => TransactionsPage(),
        '/transaction': (BuildContext context) => TransactionPage(),
      },
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan[400],
        accentColor: Colors.deepOrange[200],
        textTheme: TextTheme(),
      ),
      home: LoginPage(),
    );
  }
}
