import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../utils/constants.dart';
import '../models/formation.dart';

abstract class RemoteDataSource {
  //auth functions
  Future<UserCredential?> signInUser(String email, String password);
  Future<UserCredential?> signUpUser(String email, String password);
  Future<void> signOutUser();
  Future<void> forgetPasswordUser(String email);
  Future<void> addUser(UserModel user);
  Future<UserModel> getUser(String id);

  // rest of the fonctions
  Future<Formation> addFormation(Formation formation);
  Future<Formation> editFormation(Formation formation);
  Future<Formation> deleteFormation(Formation formation);
  Stream<List<Formation>> listFormations();

  //Upload files to flutter storage

  Future<String> uploadFile(File file);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  @override
  Future<Formation> addFormation(Formation formation) async {
    FirebaseFirestore.instance
        .collection(FirebaseCollections.courses)
        .doc(formation.id)
        .set(formation.toJson());
    return formation;
  }

  @override
  Future<Formation> deleteFormation(Formation formation) async {
    FirebaseFirestore.instance
        .collection(FirebaseCollections.courses)
        .doc(formation.id)
        .delete();
    return formation;
  }

  @override
  Future<Formation> editFormation(Formation formation) async {
    FirebaseFirestore.instance
        .collection(FirebaseCollections.courses)
        .doc(formation.id)
        .set(formation.toJson());
    return formation;
  }

  @override
  Stream<List<Formation>> listFormations() {
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.courses)
        .snapshots()
        .map(
      (QuerySnapshot snapshot) {
        return snapshot.docs.map(
          (DocumentSnapshot doc) {
            return Formation.fromSnapshot(doc);
          },
        ).toList();
      },
    );
  }

  @override
  Future<void> addUser(UserModel user) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection(FirebaseCollections.users);
      await users.doc(user.id).set(user.toJson());
    } catch (e) {
      print("Firestore error: $e");
    }
  }

  @override
  Future<UserCredential?> signInUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      // Handle sign-in errors

      print(e.toString());
      return null;
    }
  }

  @override
  Future<UserCredential?> signUpUser(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } catch (e) {
      // Handle sign-up errors
      print(e.toString());
      return null;
    }
  }

  @override
  Future<void> forgetPasswordUser(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return;
    } catch (e) {
      // Handle sign-up errors
      print(e.toString());
      return;
    }
  }

  @override
  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<UserModel> getUser(String id) async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection(FirebaseCollections.users)
        .doc(id)
        .get();
    return UserModel.fromSnapshot(user);
  }

  @override
  Future<String> uploadFile(File file) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('uploads/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      return downloadURL;
    } catch (e) {
      print('Error uploading file: $e');
      return '';
    }
  }
}
