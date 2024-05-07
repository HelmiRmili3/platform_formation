import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../models/formation.dart';

abstract class RemoteDataSource {
  //auth functions
  Future<UserCredential?> signInUser(String email, String password);
  Future<UserCredential?> signUpUser(String email, String password);
  Future<void> signOutUser();
  Future<void> forgetPasswordUser(String email);
  Future<void> addUser(UserModel user);
  Future<void> deleteUser(String id);
  Future<UserModel> getUser(String id);

  // rest of the fonctions
  Future<Formation> addFormation(Formation formation);
  Future<Formation> editFormation(Formation formation);
  Future<void> deleteFormation(String formation);

  Future<void> addSeance(String formationId, Seance seance);
  // streams
  Stream<List<Formation>> listFormations();
  Stream<List<UserModel>> listUsers();

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
  Future<void> deleteFormation(String formationId) async {
    FirebaseFirestore.instance
        .collection(FirebaseCollections.courses)
        .doc(formationId)
        .delete();
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
    return FirebaseFirestore.instance.collection("courses").snapshots().map(
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
  Stream<List<UserModel>> listUsers() {
    return FirebaseFirestore.instance
        .collection(FirebaseCollections.users)
        .snapshots()
        .map(
      (QuerySnapshot snapshot) {
        return snapshot.docs.map(
          (DocumentSnapshot doc) {
            return UserModel.fromSnapshot(doc);
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
      debugPrint("Firestore error: $e");
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
      debugPrint(e.toString());
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
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Future<void> forgetPasswordUser(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return;
    } catch (e) {
      debugPrint(e.toString());
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
      debugPrint('Error uploading file: $e');
      return '';
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection(FirebaseCollections.users);
      await users.doc(id).delete();
    } catch (e) {
      debugPrint("Firestore error: $e");
    }
  }

  @override
  Future<void> addSeance(String formationId, Seance newSeance) async {
    try {
      DocumentReference formationRef =
          FirebaseFirestore.instance.collection('formations').doc(formationId);

      DocumentSnapshot formationSnapshot = await formationRef.get();

      if (formationSnapshot.exists) {
        // List<Map<String, dynamic>> currentSeances =
        //     List<Map<String, dynamic>>.from(
        //         formationSnapshot.data()?['seances']);

        // currentSeances.add(newSeance.toMap());

        //  await formationRef.update({'seances': currentSeances});

        debugPrint('Seance added to formation successfully!');
      } else {
        debugPrint('Formation document does not exist!');
      }
    } catch (e) {
      debugPrint('Error adding seance to formation: $e');
    }
  }
}
