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
  Future<List<Seance>> listSeances(String formationId);

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
      DocumentReference formationRef = await FirebaseFirestore.instance
          .collection(FirebaseCollections.courses)
          .doc(formationId)
          .collection("seances")
          .add(newSeance
              .toJson()); // Assuming newSeance has a toMap method to convert it to a Map

      debugPrint('Seance added with ID: ${formationRef.id}');
    } catch (e) {
      debugPrint('Error adding seance to formation: $e');
    }
  }

  @override
  Future<List<Seance>> listSeances(String formationId) async {
    // Get the reference to the collection of seances under the specified formationId
    CollectionReference seancesRef = FirebaseFirestore.instance
        .collection(FirebaseCollections.courses)
        .doc(formationId)
        .collection(FirebaseCollections.seances);

    // Get the documents from Firestore
    QuerySnapshot seancesSnapshot = await seancesRef.get();

    // Convert each document into a Seance object and store them in a list
    List<Seance> seancesList = seancesSnapshot.docs.map((doc) {
      return Seance.fromSnapshot(doc);
    }).toList();

    // Return the list of seances
    return seancesList;
  }
}
