import '../entities/talhao_entity.dart';
import '../repositories/talhao_repository.dart';

class ObterTalhaoUsecase {
  final TalhaoRepository repository;

  ObterTalhaoUsecase({required this.repository});

  Future<TalhaoEntity> call(String id) async {
    return await repository.getTalhaoById(id);
  }
}
