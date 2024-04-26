import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/signin_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInRepositoryImpl implements SignInRepository {
  final RemoteDataSource remoteDataSource;

  SignInRepositoryImpl({
    required this.remoteDataSource,
  });



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
  Future<UserModel> getUser(String id) {
    return remoteDataSource.getUser(id);
  }
}
