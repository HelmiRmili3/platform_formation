import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/admin_repository.dart';

class AdminGetUserUseCase {
  final AdminRepository repository;

  AdminGetUserUseCase(this.repository);

  Future<UserModel> call(String userId) {
    return repository.getUser(userId);
  }
}
