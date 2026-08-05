import '../entities/talhao_entity.dart';
import '../repositories/talhao_repository.dart';

class EditarTalhaoUsecase {
  final TalhaoRepository repository;

  EditarTalhaoUsecase({required this.repository});

  Future<TalhaoEntity> call({
    required String id,
    required String nome,
    required double hectares,
  }) async {
    if (nome.isEmpty) {
      throw Exception('Nome não pode estar vazio');
    }
    if (hectares <= 0) {
      throw Exception('Hectares deve ser maior que 0');
    }
    return await repository.updateTalhao(id, nome, hectares);
  }
}
