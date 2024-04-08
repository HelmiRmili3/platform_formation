import 'package:dartz/dartz.dart';

import '../../../../data/models/formation.dart';
import '../../../../shared/errors/failure.dart';
import '../../../../utils/usecase.dart';
import '../../../repositories/formation_repository.dart';

class FetchFormationsUseCase
    implements UseCase<Stream<List<Formation>>, NoParams> {
  final FormationRepository repository;
  FetchFormationsUseCase(this.repository);

  @override
  Future<Either<Failure, Stream<List<Formation>>>> call(NoParams params) {
    return repository.getAll();
  }
}
