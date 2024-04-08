import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/repositories/formation_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

import '../../../../utils/usecase.dart';

class AddFormationUseCase implements UseCase<Formation, Params<Formation>> {
  final FormationRepository repository;
  AddFormationUseCase(this.repository);

  @override
  Future<Either<Failure, Formation>> call(Params params) async {
    return await repository.add(params.data);
  }
}
