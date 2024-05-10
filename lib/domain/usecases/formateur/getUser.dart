import 'package:eplatfrom/domain/repositories/formateur_repository.dart';

import '../../../data/models/user.dart';

class GetUserUseCase {
  final FormateurRepository repository;

  GetUserUseCase(this.repository);

  Future<UserModel> call(String id) async {
    return repository.getUser(id);
  }
}
