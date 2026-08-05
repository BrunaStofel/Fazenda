import 'custo_entity.dart';

class TalhaoEntity {
  final String? id;
  final String nome;
  final double hectares;
  final List<CustoEntity> custos;

  TalhaoEntity({
    this.id,
    required this.nome,
    required this.hectares,
    this.custos = const [],
  });

  double get custoTotal => custos.fold(0, (sum, custo) => sum + custo.valor);

  TalhaoEntity copyWith({
    String? id,
    String? nome,
    double? hectares,
    List<CustoEntity>? custos,
  }) {
    return TalhaoEntity(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      hectares: hectares ?? this.hectares,
      custos: custos ?? this.custos,
    );
  }

  @override
  String toString() =>
      'TalhaoEntity(id: $id, nome: $nome, hectares: $hectares, custos: $custos)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TalhaoEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          nome == other.nome &&
          hectares == other.hectares &&
          custos == other.custos;

  @override
  int get hashCode =>
      id.hashCode ^ nome.hashCode ^ hectares.hashCode ^ custos.hashCode;
}
