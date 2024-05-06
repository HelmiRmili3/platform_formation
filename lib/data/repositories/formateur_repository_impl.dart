import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/repositories/formateur_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

class FormateurRepositoyImpl implements FormateurRepository {
  final RemoteDataSource remoteDataSource;

  FormateurRepositoyImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Formation>> add(Formation formation) async {
    try {
      final result = await remoteDataSource.addFormation(formation);
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> delete(String formationId) async {
    try {
      final result = await remoteDataSource.deleteFormation(formationId);
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Formation>> edit(Formation formation) async {
    try {
      final result = await remoteDataSource.editFormation(formation);
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }

  @override
  Stream<List<Formation>> getAll() {
    return remoteDataSource.listFormations();
  }
}