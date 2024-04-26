import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

abstract class SignInRepository {
  Future<Either<Failure, void>> signin(String email, String password);
  Future<UserModel> getUser(String id);
}
