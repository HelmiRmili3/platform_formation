import 'package:dartz/dartz.dart';
import 'package:eplatfrom/domain/repositories/formateur_repository.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

import '../../../utils/usecase.dart';

class DeleteFormationUseCase implements UseCase<void, Params<String>> {
  final FormateurRepository repository;
  DeleteFormationUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(Params<String> params) async {
    return await repository.delete(params.data);
  }
}
