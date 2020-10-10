import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user.dart';

class DataRepository {
  final CollectionReference collectionUser =
      Firestore.instance.collection('users');

  final CollectionReference collectionTransaction =
      Firestore.instance.collection('transactions');

  Stream<QuerySnapshot> getStream() {
    return collectionUser.snapshots();
  }

  Stream<QuerySnapshot> getStreamCollections() {
    return collectionTransaction.snapshots();
  }

  Future<DocumentReference> addUser(User user) {
    return collectionUser.add(user.toJson());
  }

  updateUser(User user) async {
    await collectionUser
        .document(user.reference.documentID)
        .updateData(user.toJson());
  }
}
