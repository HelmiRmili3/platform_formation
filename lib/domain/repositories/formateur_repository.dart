import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

abstract class FormateurRepository {
  Future<Either<Failure, Formation>> add(Formation formation);
  Future<Either<Failure, Formation>> edit(Formation formation);
  Future<Either<Failure, void>> delete(String formationId);
  Future<UserModel> getUser(String id);
  Stream<List<Formation>> getAll();
}
