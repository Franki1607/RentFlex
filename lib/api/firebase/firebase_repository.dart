import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<T?> getDocument<T>({
    required String collectionName,
    required String documentId,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
      await _firestore.collection(collectionName).doc(documentId).get();
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
    required String collectionName,
    required String documentId,
    required T data,
    required Map<String, dynamic> Function(T) toMap,
  }) async {
    try {
      final Map<String, dynamic> dataMap = toMap(data);
      await _firestore.collection(collectionName).doc(documentId).set(dataMap, SetOptions(merge: true));
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteDocument({
    required String collectionName,
    required String documentId,
  }) async {
    try {
      await _firestore.collection(collectionName).doc(documentId).delete();
    } catch (e) {
      throw e;
    }
  }
}
