import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/admin_repository.dart';

class AdminGetUsersUseCase {
  final AdminRepository repository;

  AdminGetUsersUseCase(this.repository);

  Stream<List<UserModel>> call() {
    return repository.getUsers();
  }
}
