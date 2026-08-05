import '../entities/talhao_entity.dart';
import '../repositories/talhao_repository.dart';

class CriarTalhaoUsecase {
  final TalhaoRepository repository;

  CriarTalhaoUsecase({required this.repository});

  Future<TalhaoEntity> call({
    required String nome,
    required double hectares,
  }) async {
    if (nome.isEmpty) {
      throw Exception('Nome não pode estar vazio');
    }
    if (hectares <= 0) {
      throw Exception('Hectares deve ser maior que 0');
    }
    return await repository.createTalhao(nome, hectares);
  }
}
