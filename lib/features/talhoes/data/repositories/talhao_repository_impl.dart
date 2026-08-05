import '../../domain/entities/talhao_entity.dart';
import '../../domain/entities/custo_entity.dart';
import '../../domain/repositories/talhao_repository.dart';
import '../datasources/talhao_datasource.dart';

class TalhaoRepositoryImpl implements TalhaoRepository {
  final TalhaoDataSource remoteDataSource;

  TalhaoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<TalhaoEntity>> getTalhoes() async {
    try {
      final models = await remoteDataSource.getTalhoes();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Erro ao obter talhões: $e');
    }
  }

  @override
  Future<TalhaoEntity> getTalhaoById(String id) async {
    try {
      final model = await remoteDataSource.getTalhaoById(id);
      return model.toEntity();
    } catch (e) {
      throw Exception('Erro ao obter talhão: $e');
    }
  }

  @override
  Future<TalhaoEntity> createTalhao(String nome, double hectares) async {
    try {
      final model = await remoteDataSource.createTalhao(nome, hectares);
      return model.toEntity();
    } catch (e) {
      throw Exception('Erro ao criar talhão: $e');
    }
  }

  @override
  Future<TalhaoEntity> updateTalhao(String id, String nome, double hectares) async {
    try {
      final model = await remoteDataSource.updateTalhao(id, nome, hectares);
      return model.toEntity();
    } catch (e) {
      throw Exception('Erro ao atualizar talhão: $e');
    }
  }

  @override
  Future<void> deleteTalhao(String id) async {
    try {
      await remoteDataSource.deleteTalhao(id);
    } catch (e) {
      throw Exception('Erro ao deletar talhão: $e');
    }
  }

  @override
  Future<CustoEntity> createCusto(
    String talhaoId,
    String descricao,
    double valor,
    DateTime? data,
  ) async {
    try {
      final model = await remoteDataSource.createCusto(talhaoId, descricao, valor, data);
      return model.toEntity();
    } catch (e) {
      throw Exception('Erro ao criar custo: $e');
    }
  }

  @override
  Future<void> deleteCusto(String custoId) async {
    try {
      await remoteDataSource.deleteCusto(custoId);
    } catch (e) {
      throw Exception('Erro ao deletar custo: $e');
    }
  }
}
