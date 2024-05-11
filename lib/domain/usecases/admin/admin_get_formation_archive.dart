import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/domain/repositories/admin_repository.dart';

class AdminGetFormationsArchiveUseCase {
  final AdminRepository repository;

  AdminGetFormationsArchiveUseCase(this.repository);

  Stream<List<Formation>> call() {
    return repository.getFormationsArchive();
  }
}
