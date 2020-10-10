import 'package:bpc_flutter_test/data_repository.dart';
import 'package:bpc_flutter_test/models/transaction.dart';
import 'package:bpc_flutter_test/services/screen_arguments.dart';
import 'package:flutter/material.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from ModalRoute settings and define as ScreenArguments.
    final TransactionListArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/transactions',
                  arguments: LoginArguments(user: args.user));
            },
            child: Icon(
              Icons.arrow_back_ios, // add custom icons also
            ),
          ),
          title: Text('Transaction No_ ${args.transaction.id}')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [buildRow(args.transaction, args.user)],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRow(TransactionModel transaction, String user) {
    void _cancelCurrentTransaction() {
      final DataRepository repository = DataRepository();
      var list = repository.collectionUser.document(user).snapshots();
      list.forEach((element) {
        element.data.forEach((key, value) {
          if (key == 'transactions') {
            print(value[transaction.id]);
          }
        });
      });
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/transaction');
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(flex: 1, child: Text('Number:')),
                  Expanded(
                    flex: 4,
                    child: Text(transaction.id.toString()),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('Type:'),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(transaction.type),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('Sum:'),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(transaction.sum.toString()),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('Total:'),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(transaction.total.toString()),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('Commission:'),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(transaction.commission.toString()),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('Id:'),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(transaction.id.toString()),
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text('Date:'),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(transaction.date.toString()),
                  ),
                ],
              ),
              SizedBox(
                height: 32.0,
              ),
              RaisedButton(
                color: Colors.redAccent,
                onPressed: () {
                  _cancelCurrentTransaction();
                },
                child: Text('Cancel This Transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
