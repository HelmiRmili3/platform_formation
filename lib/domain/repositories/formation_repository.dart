import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

abstract class FormationRepository {
  Future<Either<Failure, Formation>> add(Formation formation);
  Future<Either<Failure, Formation>> edit(Formation formation);
  Future<Either<Failure, Formation>> delete(Formation formation);
  Future<Either<Failure, Stream<List<Formation>>>> getAll();
}
