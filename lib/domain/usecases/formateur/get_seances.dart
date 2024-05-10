import 'package:eplatfrom/data/models/seance.dart';
import 'package:eplatfrom/domain/repositories/formateur_repository.dart';

class FetchSeancessUseCase {
  final FormateurRepository repository;
  FetchSeancessUseCase(this.repository);

  Future<List<Seance>> call(String seances) {
    return repository.getSeances(seances);
  }
}
