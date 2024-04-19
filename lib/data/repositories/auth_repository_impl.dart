import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/auth_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';
import 'package:eplatfrom/utils/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> forgetPassword(String email) async {
    try {
      final result = await remoteDataSource.forgetPasswordUser(email);
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await remoteDataSource.signOutUser();
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signin(
      String email, String password) async {
    try {
      final result = await remoteDataSource.signInUser(email, password);
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, UserCredential?>> signup(
    String name,
    String email,
    String password,
    File image,
  ) async {
    try {
      // signup user
      final result = await remoteDataSource.signUpUser(email, password);

      if (result != null) {
        // upload image to flutter storage

        await remoteDataSource.uploadFile(image).then((imageUrl) {
          // add the user data firebase firestore
          remoteDataSource.addUser(UserModel(
              id: result.user!.uid,
              name: name,
              email: email,
              role: Role.etudiant,
              image: imageUrl));
        });
      }

      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

  @override
  Future<UserModel> getUser(String id) {
    return remoteDataSource.getUser(id);
  }
}
