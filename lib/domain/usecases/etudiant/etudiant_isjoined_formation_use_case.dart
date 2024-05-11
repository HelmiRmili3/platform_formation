import 'package:eplatfrom/domain/repositories/etudiant_repository.dart';

class EtudiantIsJoinFormationUserUseCase {
  final EtudiantRepository repository;

  EtudiantIsJoinFormationUserUseCase(this.repository);

  Future<bool> call(String formationId, String etudiantId) {
    return repository.isJoined(formationId, etudiantId);
  }
}
