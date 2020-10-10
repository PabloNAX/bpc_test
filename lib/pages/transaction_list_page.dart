import 'package:bpc_flutter_test/data_repository.dart';
import 'package:bpc_flutter_test/models/transaction.dart';
import 'package:bpc_flutter_test/models/user.dart';
import 'package:bpc_flutter_test/services/screen_arguments.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  final DataRepository repository = DataRepository();

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from ModalRoute settings and define as ScreenArguments.
    final LoginArguments args = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.connect_without_contact),
                text: 'Transaction List',
              ),
              Tab(
                icon: Icon(Icons.donut_large),
                text: 'Donut Diagram',
              ),
            ],
          ),
          title: Text('Transactions'),
        ),
        body: TabBarView(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: repository.getStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return _buildList(context, snapshot.data.documents, args.user);
              },
            ),
            Text(''),
          ],
        ),
      ),
    );
  }

  Widget _buildList(
      BuildContext context, List<DocumentSnapshot> snapshot, userId) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot
          .map((data) => _buildListItem(context, data, userId))
          .toList(),
    );
  }

  Widget _buildListItem(
      BuildContext context, DocumentSnapshot snapshot, userId) {
    final user = User.fromSnapshot(snapshot);
    if (user == null) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(16.0),
      itemCount: user.transactions == null ? 0 : user.transactions.length,
      itemBuilder: (BuildContext context, int index) {
        return buildRow(user.transactions[index], userId);
      },
    );
  }

  Widget buildRow(TransactionModel transaction, String user) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, '/transaction',
            arguments:
                TransactionListArguments(user: user, transaction: transaction));
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
            ],
          ),
        ),
      ),
    );
  }
}
