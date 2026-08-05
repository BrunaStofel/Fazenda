import '../../domain/entities/talhao_entity.dart';
import 'custo_model.dart';

class TalhaoModel extends TalhaoEntity {
  TalhaoModel({
    super.id,
    required super.nome,
    required super.hectares,
    List<CustoModel> super.custos = const [],
  });

  factory TalhaoModel.fromJson(Map<String, dynamic> json) {
    final custosData = json['custos'] as List<dynamic>? ?? [];
    final custos = custosData
        .map((custo) => CustoModel.fromJson(custo as Map<String, dynamic>))
        .toList();

    return TalhaoModel(
      id: json['id'] as String?,
      nome: json['nome'] as String? ?? '',
      hectares: (json['hectares'] as num?)?.toDouble() ?? 0.0,
      custos: custos,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'hectares': hectares,
      'custos': (custos as List<CustoModel>?)?.map((c) => c.toJson()).toList(),
    };
  }

  TalhaoEntity toEntity() {
    return TalhaoEntity(
      id: id,
      nome: nome,
      hectares: hectares,
      custos: custos,
    );
  }
}
