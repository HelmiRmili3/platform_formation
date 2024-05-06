import 'package:eplatfrom/data/datasources/remote_data_source.dart';
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/domain/repositories/etudiant_repository.dart';

class EtudiantRepositoryImpl implements EtudiantRepository {
  final RemoteDataSource remoteDataSource;

  EtudiantRepositoryImpl({
    required this.remoteDataSource,
  });
  @override
  Stream<List<Formation>> getAll() {
    return remoteDataSource.listFormations();
  }

  @override
  Future<UserModel> getUser(String userId) {
    return remoteDataSource.getUser(userId);
  }
}
