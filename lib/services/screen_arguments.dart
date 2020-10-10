import 'package:bpc_flutter_test/models/transaction.dart';

class TransactionListArguments {
  final String user;
  final TransactionModel transaction;
  TransactionListArguments({this.user, this.transaction});
}

class LoginArguments {
  final String user;
  LoginArguments({this.user});
}
