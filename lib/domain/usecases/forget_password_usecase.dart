import 'package:dartz/dartz.dart';
import 'package:eplatfrom/domain/repositories/auth_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<Either<Failure, void>> call(String email) async {
    return repository.forgetPassword(email);
  }
}