import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/data/models/user.dart';

abstract class EtudiantRepository {
  Future<UserModel> getUser(String userId);
  Future<List<Seance>> getSeances(String formationId);
  Future<bool> isJoined(String formationId, String etudiantId);
  Future<void> joinFormation(String formationId, UserModel joinedUser);
  Stream<List<Formation>> getAll();
}
