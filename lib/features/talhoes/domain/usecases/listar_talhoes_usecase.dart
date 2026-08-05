import '../entities/talhao_entity.dart';
import '../repositories/talhao_repository.dart';

class ListarTalhoesUsecase {
  final TalhaoRepository repository;

  ListarTalhoesUsecase({required this.repository});

  Future<List<TalhaoEntity>> call() async {
    return await repository.getTalhoes();
  }
}
