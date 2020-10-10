import 'package:bpc_flutter_test/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  final int id;
  final String email;
  final String password;
  List<TransactionModel> transactions = List<TransactionModel>();
  DocumentReference reference;

  User(
      {@required this.id,
      @required this.email,
      @required this.password,
      this.transactions,
      this.reference});

  factory User.fromSnapshot(DocumentSnapshot snapshot) {
    User newUser = User.fromJson(snapshot.data);
    newUser.reference = snapshot.reference;
    return newUser;
  }

  factory User.fromJson(Map<String, dynamic> json) => _UserFromJson(json);

  Map<String, dynamic> toJson() => _UserToJson(this);

  @override
  String toString() => "User<$email>";
}

User _UserFromJson(Map<String, dynamic> json) {
  return User(
      id: json['id'] as int,
      email: json['email'] as String,
      password: json['password'] as String,
      transactions: _convertTransactions(json['transactions'] as List));
}

List<TransactionModel> _convertTransactions(List transactionMap) {
  if (transactionMap == null) {
    return null;
  }
  List<TransactionModel> transactions = List<TransactionModel>();
  transactionMap.forEach((value) {
    transactions.add(TransactionModel.fromJson(value));
  });
  return transactions;
}

Map<String, dynamic> _UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'password': instance.password,
      'transactions': _TransactionModelList(instance.transactions),
    };

List<Map<String, dynamic>> _TransactionModelList(
    List<TransactionModel> transactions) {
  if (transactions == null) {
    return null;
  }
  List<Map<String, dynamic>> transactionMap = List<Map<String, dynamic>>();
  transactions.forEach((transaction) {
    transactionMap.add(transaction.toJson());
  });
  return transactionMap;
}
