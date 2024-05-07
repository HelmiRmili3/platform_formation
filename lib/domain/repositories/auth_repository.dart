import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> signup(
      String name, String email, String password, File image);
  Future<Either<Failure, void>> signin(String email, String password);

  Future<UserModel> getUser(String id);

  Future<Either<Failure, void>> forgetPassword(String email);
  Future<Either<Failure, void>> logout();
}
