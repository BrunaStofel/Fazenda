import '../models/talhao_model.dart';
import '../models/custo_model.dart';

/// Common interface for both remote and local data sources
abstract class TalhaoDataSource {
  Future<List<TalhaoModel>> getTalhoes();
  Future<TalhaoModel> getTalhaoById(String id);
  Future<TalhaoModel> createTalhao(String nome, double hectares);
  Future<TalhaoModel> updateTalhao(String id, String nome, double hectares);
  Future<void> deleteTalhao(String id);
  Future<CustoModel> createCusto(String talhaoId, String descricao, double valor, DateTime? data);
  Future<void> deleteCusto(String custoId);
}
