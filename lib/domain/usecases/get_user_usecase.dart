import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/signin_repository.dart';

class GetUserUseCase {
  final SignInRepository repository;

  GetUserUseCase( this.repository);

  Future<UserModel> call(String id) async {
    return repository.getUser(id);
  }
}
