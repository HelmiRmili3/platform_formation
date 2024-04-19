import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository repository;

  GetUserUseCase(this.repository);

  Future<UserModel> call(String id) async {
    return repository.getUser(id);
  }
}
