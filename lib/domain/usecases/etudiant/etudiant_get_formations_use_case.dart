import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/repositories/etudiant_repository.dart';

class EtudiantGetFormationsUseCase {
  final EtudiantRepository repository;
  EtudiantGetFormationsUseCase(this.repository);

  Stream<List<Formation>> call() {
    return repository.getAll();
  }
}
