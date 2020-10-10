import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  int id;
  String type;
  int number;
  int sum;
  int commission;
  int total;
  DateTime date;
  DocumentReference reference;

  TransactionModel({
    this.id,
    this.type,
    this.commission,
    this.date,
    this.number,
    this.sum,
    this.total,
    this.reference,
  });

  factory TransactionModel.fromSnapshot(DocumentSnapshot snapshot) {
    TransactionModel newTransactionModel =
        TransactionModel.fromJson(snapshot.data);
    newTransactionModel.reference = snapshot.reference;
    return newTransactionModel;
  }

  factory TransactionModel.fromJson(Map<dynamic, dynamic> json) =>
      _TransactionModelFromJson(json);

  Map<String, dynamic> toJson() => _TransactionModelToJson(this);

  @override
  String toString() => "TransactionModel<$id>";
}

TransactionModel _TransactionModelFromJson(Map<dynamic, dynamic> json) {
  return TransactionModel(
    id: json['id'] as int,
    date: json['date'] == null ? null : (json['date'] as Timestamp).toDate(),
    sum: json['sum'] as int,
    type: json['type'] as String,
    commission: json['commission'] as int,
    number: json['number'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _TransactionModelToJson(TransactionModel instance) =>
    <String, dynamic>{
      'date': instance.date,
      'type': instance.type,
      'id': instance.id,
      'sum': instance.sum,
      'commission': instance.commission,
      'total': instance.total,
      'number': instance.number,
    };
