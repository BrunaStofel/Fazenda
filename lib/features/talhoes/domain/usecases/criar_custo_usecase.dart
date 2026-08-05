import '../entities/custo_entity.dart';
import '../repositories/talhao_repository.dart';

class CriarCustoUsecase {
  final TalhaoRepository repository;

  CriarCustoUsecase({required this.repository});

  Future<CustoEntity> call({
    required String talhaoId,
    required String descricao,
    required double valor,
    DateTime? data,
  }) async {
    if (descricao.isEmpty) {
      throw Exception('Descrição não pode estar vazia');
    }
    if (valor <= 0) {
      throw Exception('Valor deve ser maior que 0');
    }
    return await repository.createCusto(talhaoId, descricao, valor, data);
  }
}
