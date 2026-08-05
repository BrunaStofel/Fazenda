import 'package:dio/dio.dart';
import '../models/talhao_model.dart';
import '../models/custo_model.dart';

abstract class TalhaoRemoteDataSource {
  Future<List<TalhaoModel>> getTalhoes();
  Future<TalhaoModel> getTalhaoById(String id);
  Future<TalhaoModel> createTalhao(String nome, double hectares);
  Future<TalhaoModel> updateTalhao(String id, String nome, double hectares);
  Future<void> deleteTalhao(String id);
  Future<CustoModel> createCusto(String talhaoId, String descricao, double valor, DateTime? data);
  Future<void> deleteCusto(String custoId);
}

class TalhaoRemoteDataSourceImpl implements TalhaoRemoteDataSource {
  final Dio dio;

  TalhaoRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<TalhaoModel>> getTalhoes() async {
    try {
      final response = await dio.get('/talhoes');
      final List<dynamic> data = response.data as List<dynamic>;
      return data
          .map((json) => TalhaoModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Erro ao carregar talhões: ${e.message}');
    }
  }

  @override
  Future<TalhaoModel> getTalhaoById(String id) async {
    try {
      final response = await dio.get('/talhoes/$id');
      return TalhaoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Erro ao carregar talhão: ${e.message}');
    }
  }

  @override
  Future<TalhaoModel> createTalhao(String nome, double hectares) async {
    try {
      final response = await dio.post(
        '/talhoes',
        data: {'nome': nome, 'hectares': hectares},
      );
      return TalhaoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Erro ao criar talhão: ${e.message}');
    }
  }

  @override
  Future<TalhaoModel> updateTalhao(String id, String nome, double hectares) async {
    try {
      final response = await dio.put(
        '/talhoes/$id',
        data: {'nome': nome, 'hectares': hectares},
      );
      return TalhaoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Erro ao atualizar talhão: ${e.message}');
    }
  }

  @override
  Future<void> deleteTalhao(String id) async {
    try {
      await dio.delete('/talhoes/$id');
    } on DioException catch (e) {
      throw Exception('Erro ao deletar talhão: ${e.message}');
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
      final response = await dio.post(
        '/talhoes/$talhaoId/custos',
        data: {
          'descricao': descricao,
          'valor': valor,
          'data': data?.toIso8601String(),
        },
      );
      return CustoModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('Erro ao criar custo: ${e.message}');
    }
  }

  @override
  Future<void> deleteCusto(String custoId) async {
    try {
      await dio.delete('/custos/$custoId');
    } on DioException catch (e) {
      throw Exception('Erro ao deletar custo: ${e.message}');
    }
  }
}
