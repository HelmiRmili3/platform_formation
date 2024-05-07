import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/formateur_repository.dart';

class GetUserUseCase {
  final FormateurRepository repository;

  GetUserUseCase(this.repository);

  Future<UserModel> call(String id) async {
    return repository.getUser(id);
  }
}
