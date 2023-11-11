import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {

  Future<T?> getDocument<T>({
    required FirebaseFirestore firestore,
    required String collectionName,
    required String documentId,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await firestore.collection(collectionName).doc(documentId).get();
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        return fromMap(data!);
      }
      return null;
    } catch (e) {
      throw e;
    }
  }

  Future<void> setDocument<T>({
    required FirebaseFirestore firestore,
    required String collectionName,
    required String documentId,
    required T data,
    required Map<String, dynamic> Function(T) toMap,
  }) async {
    try {
      final Map<String, dynamic> dataMap = toMap(data);
      await firestore.collection(collectionName).doc(documentId).set(dataMap, SetOptions(merge: true));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteDocument({
    required FirebaseFirestore firestore,
    required String collectionName,
    required String documentId,
  }) async {
    try {
      await firestore.collection(collectionName).doc(documentId).delete();
    } catch (e) {
      throw e;
    }
  }

}
