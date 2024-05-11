import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/etudiant_repository.dart';

class EtudiantJoinFormationUserUseCase {
  final EtudiantRepository repository;

  EtudiantJoinFormationUserUseCase(this.repository);

  Future<void> call(String formationId, UserModel joinedUser) {
    return repository.joinFormation(formationId, joinedUser);
  }
}
