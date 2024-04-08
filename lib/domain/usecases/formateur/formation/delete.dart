import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/repositories/formation_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

import '../../../../utils/usecase.dart';

class DeleteFormationUseCase implements UseCase<Formation, Params<Formation>> {
  final FormationRepository repository;
  DeleteFormationUseCase(this.repository);

  @override
  Future<Either<Failure, Formation>> call(Params params) async {
    return await repository.delete(params.data);
  }
}
