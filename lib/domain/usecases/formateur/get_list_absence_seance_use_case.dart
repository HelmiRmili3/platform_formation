import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/formateur_repository.dart';

class FetchListAbsencePerSeanceUseCase {
  final FormateurRepository repository;
  FetchListAbsencePerSeanceUseCase(this.repository);

  Stream<List<UserModel>> call(String formationId, String seanceId) {
    return repository.listAbsencePerSeance(formationId, seanceId);
  }
}
