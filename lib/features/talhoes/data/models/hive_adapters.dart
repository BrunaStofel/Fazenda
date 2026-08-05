import 'package:hive/hive.dart';
import 'talhao_model.dart';
import 'custo_model.dart';

class TalhaoModelAdapter extends TypeAdapter<TalhaoModel> {
  @override
  final int typeId = 0;

  @override
  TalhaoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TalhaoModel(
      id: fields[0] as String?,
      nome: fields[1] as String,
      hectares: fields[2] as double,
      custos: (fields[3] as List?)?.cast<CustoModel>() ?? [],
    );
  }

  @override
  void write(BinaryWriter writer, TalhaoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nome)
      ..writeByte(2)
      ..write(obj.hectares)
      ..writeByte(3)
      ..write(obj.custos);
  }
}

class CustoModelAdapter extends TypeAdapter<CustoModel> {
  @override
  final int typeId = 1;

  @override
  CustoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustoModel(
      id: fields[0] as String?,
      descricao: fields[1] as String,
      valor: fields[2] as double,
      data: fields[3] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, CustoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.descricao)
      ..writeByte(2)
      ..write(obj.valor)
      ..writeByte(3)
      ..write(obj.data);
  }
}
