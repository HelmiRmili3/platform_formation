import 'package:dartz/dartz.dart';
import 'package:eplatfrom/domain/repositories/signin_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInUseCase {
  final SignInRepository repository;

  SignInUseCase(this.repository);

  Future<Either<Failure, UserCredential?>> call(
      String email, String password) async {
    return repository.signIn(email, password);
  }
}
