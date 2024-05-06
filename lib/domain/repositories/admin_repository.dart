import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/user.dart';

abstract class AdminRepository {
  //Futures
  Future<UserModel> getUser(String userId);
  Future<void> deleteUser(String userId);

  //streams
  Stream<List<Formation>> getFormations();
  Stream<List<UserModel>> getUsers();
}
