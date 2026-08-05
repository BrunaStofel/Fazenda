class CustoEntity {
  final String? id;
  final String descricao;
  final double valor;
  final DateTime? data;

  CustoEntity({
    this.id,
    required this.descricao,
    required this.valor,
    this.data,
  });

  CustoEntity copyWith({
    String? id,
    String? descricao,
    double? valor,
    DateTime? data,
  }) {
    return CustoEntity(
      id: id ?? this.id,
      descricao: descricao ?? this.descricao,
      valor: valor ?? this.valor,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'CustoEntity(id: $id, descricao: $descricao, valor: $valor, data: $data)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustoEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          descricao == other.descricao &&
          valor == other.valor &&
          data == other.data;

  @override
  int get hashCode =>
      id.hashCode ^ descricao.hashCode ^ valor.hashCode ^ data.hashCode;
}
