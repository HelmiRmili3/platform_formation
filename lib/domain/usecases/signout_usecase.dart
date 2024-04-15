import 'package:dartz/dartz.dart';
import 'package:eplatfrom/domain/repositories/auth_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

class SignOutUseCase {
  final AuthRepository repository;
  SignOutUseCase(this.repository);
  
  Future<Either<Failure, void>> call() async {
    return repository.logout();
  }
}