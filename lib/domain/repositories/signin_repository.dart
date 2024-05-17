import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/shared/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInRepository {
  Future<Either<Failure, UserCredential?>> signIn(
      String email, String password);
  Future<UserModel> getUser(String id);
}
