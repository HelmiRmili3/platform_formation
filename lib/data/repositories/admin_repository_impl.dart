import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/admin_repository.dart';

class AdminRepositoryImpl implements AdminRepository {
  final RemoteDataSource remoteDataSource;

  AdminRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Stream<List<Formation>> getFormations() {
    return remoteDataSource.listFormations();
  }

  @override
  Future<UserModel> getUser(String userId) {
    return remoteDataSource.getUser(userId);
  }

  @override
  Stream<List<UserModel>> getUsers() {
    return remoteDataSource.listUsers();
  }

  @override
  Future<void> deleteUser(String userId) {
    return remoteDataSource.deleteUser(userId);
  }
}
