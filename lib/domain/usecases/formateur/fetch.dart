import '../../../data/models/formation.dart';
import '../../repositories/formateur_repository.dart';

class FetchFormationsUseCase {
  final FormateurRepository repository;
  FetchFormationsUseCase(this.repository);

  Stream<List<Formation>> call() {
    return repository.getAll();
  }
}
