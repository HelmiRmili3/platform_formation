import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:eplatfrom/domain/repositories/auth_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, void>> call(
    String name,
    String email,
    String password,
    File image,
  ) async {
    return repository.signup(
      name,
      email,
      password,
      image,
    );
  }
}
