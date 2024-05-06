import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/repositories/admin_repository.dart';

class AdminGetFormationsUseCase {
  final AdminRepository repository;

  AdminGetFormationsUseCase(this.repository);

  Stream<List<Formation>> call() {
    return repository.getFormations();
  }
}
