import 'package:dartz/dartz.dart';
import 'package:eplatfrom/data/models/formation.dart';
import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/data/models/user.dart';
import 'package:eplatfrom/shared/errors/failure.dart';

abstract class FormateurRepository {
  Future<Either<Failure, Formation>> add(Formation formation);
  Future<Either<Failure, Formation>> edit(Formation formation);
  Future<Either<Failure, void>> delete(String formationId);
  Future<UserModel> getUser(String id);
  Future<void> addSeance(String formationId, Seance seance);
  Stream<List<Formation>> getAll();
  Future<List<UserModel>> listEtudiantOfFormation(String formationId);
  Stream<List<UserModel>> listAbsencePerSeance(
      String formationId, String seance);

  Future<List<Seance>> getSeances(String formationId);
  Future<void> toggleEtudiantPresence(
      String formationId, String seanceId, String etudiantId);
}
