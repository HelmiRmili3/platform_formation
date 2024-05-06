import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/user.dart';

abstract class EtudiantRepository {
  Future<UserModel> getUser(String userId);
  Stream<List<Formation>> getAll();
}
