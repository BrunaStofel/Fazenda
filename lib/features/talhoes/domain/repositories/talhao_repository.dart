import '../entities/talhao_entity.dart';
import '../entities/custo_entity.dart';

abstract class TalhaoRepository {
  Future<List<TalhaoEntity>> getTalhoes();
  Future<TalhaoEntity> getTalhaoById(String id);
  Future<TalhaoEntity> createTalhao(String nome, double hectares);
  Future<TalhaoEntity> updateTalhao(String id, String nome, double hectares);
  Future<void> deleteTalhao(String id);
  Future<CustoEntity> createCusto(String talhaoId, String descricao, double valor, DateTime? data);
  Future<void> deleteCusto(String custoId);
}
