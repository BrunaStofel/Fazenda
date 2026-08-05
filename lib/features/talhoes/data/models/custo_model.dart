import '../../domain/entities/custo_entity.dart';

class CustoModel extends CustoEntity {
  CustoModel({
    super.id,
    required super.descricao,
    required super.valor,
    super.data,
  });

  factory CustoModel.fromJson(Map<String, dynamic> json) {
    return CustoModel(
      id: json['id'] as String?,
      descricao: json['descricao'] as String? ?? '',
      valor: (json['valor'] as num?)?.toDouble() ?? 0.0,
      data: json['data'] != null ? DateTime.parse(json['data'] as String) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'valor': valor,
      'data': data?.toIso8601String(),
    };
  }

  CustoEntity toEntity() {
    return CustoEntity(
      id: id,
      descricao: descricao,
      valor: valor,
      data: data,
    );
  }
}
