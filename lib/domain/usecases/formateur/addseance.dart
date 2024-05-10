import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/domain/repositories/formateur_repository.dart';

class AddSeanceUserUseCase {
  final FormateurRepository repository;

  AddSeanceUserUseCase(this.repository);

  Future<void> call(String formationId, Seance seance) async {
    return repository.addSeance(formationId, seance);
  }
}
