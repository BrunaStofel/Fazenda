import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/talhao_model.dart';
import '../models/custo_model.dart';
import 'talhao_datasource.dart';

class TalhaoLocalDataSourceImpl implements TalhaoDataSource {
  late final Box<TalhaoModel> _box;

  TalhaoLocalDataSourceImpl({required Box<TalhaoModel> box}) : _box = box;

  @override
  Future<List<TalhaoModel>> getTalhoes() async {
    try {
      return _box.values.toList();
    } catch (e) {
      throw Exception('Erro ao buscar talhões: $e');
    }
  }

  @override
  Future<TalhaoModel> getTalhaoById(String id) async {
    try {
      final talhao = _box.values.firstWhere(
        (t) => t.id == id,
        orElse: () => throw Exception('Talhão não encontrado'),
      );
      return talhao;
    } catch (e) {
      throw Exception('Erro ao buscar talhão: $e');
    }
  }

  @override
  Future<TalhaoModel> createTalhao(String nome, double hectares) async {
    try {
      final id = const Uuid().v4();
      final newTalhao = TalhaoModel(
        id: id,
        nome: nome,
        hectares: hectares,
        custos: [],
      );
      await _box.put(id, newTalhao);
      return newTalhao;
    } catch (e) {
      throw Exception('Erro ao criar talhão: $e');
    }
  }

  @override
  Future<TalhaoModel> updateTalhao(String id, String nome, double hectares) async {
    try {
      final talhao = _box.get(id);
      if (talhao == null) {
        throw Exception('Talhão não encontrado');
      }
      final updatedTalhao = TalhaoModel(
        id: talhao.id,
        nome: nome,
        hectares: hectares,
        custos: talhao.custos as List<CustoModel>,
      );
      await _box.put(id, updatedTalhao);
      return updatedTalhao;
    } catch (e) {
      throw Exception('Erro ao atualizar talhão: $e');
    }
  }

  @override
  Future<void> deleteTalhao(String id) async {
    try {
      await _box.delete(id);
    } catch (e) {
      throw Exception('Erro ao deletar talhão: $e');
    }
  }

  @override
  Future<CustoModel> createCusto(
    String talhaoId,
    String descricao,
    double valor,
    DateTime? data,
  ) async {
    try {
      final talhao = _box.get(talhaoId);
      if (talhao == null) {
        throw Exception('Talhão não encontrado');
      }

      final custoId = const Uuid().v4();
      final newCusto = CustoModel(
        id: custoId,
        descricao: descricao,
        valor: valor,
        data: data ?? DateTime.now(),
      );

      final custosList = List<CustoModel>.from(talhao.custos as List<CustoModel>);
      custosList.add(newCusto);

      final updatedTalhao = TalhaoModel(
        id: talhao.id,
        nome: talhao.nome,
        hectares: talhao.hectares,
        custos: custosList,
      );
      
      await _box.put(talhaoId, updatedTalhao);
      return newCusto;
    } catch (e) {
      throw Exception('Erro ao criar custo: $e');
    }
  }

  @override
  Future<void> deleteCusto(String custoId) async {
    try {
      final talhoes = _box.values.toList();
      for (final talhao in talhoes) {
        final updatedCustos = talhao.custos
            .where((c) => c.id != custoId)
            .cast<CustoModel>()
            .toList();
        
        if (updatedCustos.length != talhao.custos.length) {
          final updatedTalhao = TalhaoModel(
            id: talhao.id,
            nome: talhao.nome,
            hectares: talhao.hectares,
            custos: updatedCustos,
          );
          await _box.put(talhao.id!, updatedTalhao);
          return;
        }
      }
    } catch (e) {
      throw Exception('Erro ao deletar custo: $e');
    }
  }
}
