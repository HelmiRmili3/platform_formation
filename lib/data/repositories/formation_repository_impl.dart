import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/repositories/formation_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

class FormationRepositoyImpl implements FormationRepository {
  final RemoteDataSource remoteDataSource;

  FormationRepositoyImpl({
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
  Future<Either<Failure, Formation>> delete(Formation formation) async {
    try {
      final result = await remoteDataSource.deleteFormation(formation);
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
  Future<Either<Failure, Stream<List<Formation>>>> getAll() async {
    try {
      final result = remoteDataSource.listFormations();
      return Right(result);
    } catch (e) {
      return Left(Failure("Server error : ${e.toString()}"));
    }
  }
}
