import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/donor.dart';
import '../models/user.dart';
import '/utility/firebase_response.dart';
import 'package:flutter/cupertino.dart';

class FirebaseWrapper {
  FirebaseWrapper._();

  static final _instance = FirebaseWrapper._();

  factory FirebaseWrapper() {
    return _instance;
  }

  late final FirebaseFirestore _firestore;

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  Future<FirebaseResponse> createUser(String collection, User user) async {
    try {
      final querySnapshot = await _firestore
          .collection(collection)
          .where('phoneNumber', isEqualTo: user.phoneNumber)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return updateUser(collection, user);
      }

      await _firestore.collection(collection).add(user.toMap());
      return FirebaseResponse(true);
    } catch (e) {
      return FirebaseResponse(false, error: e.toString());
    }
  }

  Future<FirebaseResponse> readDonors(
      String collection, String bloodType) async {
    try {
      final List<Donor> userList = [];

      final querySnapshot = await _firestore
          .collection(collection)
          .where('bloodType', isEqualTo: bloodType)
          .get();

      for (var el in querySnapshot.docs) {
        userList.add(Donor.fromMap(el.data()));
      }

      return FirebaseResponse(true, userList: userList);
    } catch (e) {
      return FirebaseResponse(false, error: e.toString());
    }
  }

  Future<FirebaseResponse> readUser(
      String collection, String phoneNumber) async {
    try {
      final List<Donor> userList = [];

      final querySnapshot = await _firestore
          .collection(collection)
          .where('phoneNumber', isEqualTo: phoneNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return FirebaseResponse(false,
            error: 'User with this phone number not found.');
      }

      return FirebaseResponse(true,
          password: querySnapshot.docs.first['password']);
    } catch (e) {
      return FirebaseResponse(false, error: e.toString());
    }
  }

  Future<FirebaseResponse> updateUser(String collection, User user) async {
    try {
      final querySnapshot = await _firestore
          .collection(collection)
          .where('phoneNumber', isEqualTo: user.phoneNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return FirebaseResponse(false,
            error:
                'User with phone number \'${user.phoneNumber}\' can not be added');
      }

      final docId =
          querySnapshot.docs.isEmpty ? null : querySnapshot.docs.first.id;
      await _firestore.collection(collection).doc(docId).set(
            user.toMap(),
            SetOptions(merge: true),
          );

      return FirebaseResponse(true);
    } catch (e) {
      return FirebaseResponse(false, error: e.toString());
    }
  }

  Future<FirebaseResponse> deleteUser(String collection, User user) async {
    try {
      final querySnapshot = await _firestore
          .collection(collection)
          .where('phoneNumber', isEqualTo: user.phoneNumber)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return FirebaseResponse(false,
            error:
                'Can\'t find user with phone number \'${user.phoneNumber}\'.');
      }

      final docId = querySnapshot.docs.first.id;
      await _firestore.collection(collection).doc(docId).delete();

      return FirebaseResponse(true);
    } catch (e) {
      return FirebaseResponse(false, error: e.toString());
    }
  }
}
