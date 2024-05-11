import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/domain/repositories/etudiant_repository.dart';

class EtudiantGetSeancesUseCase {
  final EtudiantRepository repository;
  EtudiantGetSeancesUseCase(this.repository);

  Future<List<Seance>> call(String formationId) {
    return repository.getSeances(formationId);
  }
}
