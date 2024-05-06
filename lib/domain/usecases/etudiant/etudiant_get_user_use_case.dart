import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/etudiant_repository.dart';

class EtudiantGetUserUseCase {
  final EtudiantRepository repository;

  EtudiantGetUserUseCase(this.repository);

  Future<UserModel> call(String userId) {
    return repository.getUser(userId);
  }
}
