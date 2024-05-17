import 'package:eplatfrom/domain/repositories/formateur_repository.dart';

class ToggleEtudiantPresenceUseCase {
  final FormateurRepository repository;
  ToggleEtudiantPresenceUseCase(this.repository);

  Future<void> call(String formationId, String seanceId, String etudiantId) {
    return repository.toggleEtudiantPresence(formationId, seanceId, etudiantId);
  }
}
