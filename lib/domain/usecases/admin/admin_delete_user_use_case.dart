import 'package:eplatfrom/domain/repositories/admin_repository.dart';

class AdminDeleteUserUseCase {
  final AdminRepository repository;

  AdminDeleteUserUseCase(this.repository);

  Future<void> call(String userId) async {
    return repository.deleteUser(userId);
  }
}
