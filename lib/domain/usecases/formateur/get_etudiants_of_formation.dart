import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/formateur_repository.dart';

class FetchEtudiantOfFormationUseCase {
  final FormateurRepository repository;
  FetchEtudiantOfFormationUseCase(this.repository);

  Future<List<UserModel>> call(String formationId) {
    return repository.listEtudiantOfFormation(formationId);
  }
}
