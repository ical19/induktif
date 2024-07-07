// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technical_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TechnicalModelAdapter extends TypeAdapter<TechnicalModel> {
  @override
  final int typeId = 1;

  @override
  TechnicalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TechnicalModel(
      forDealer: fields[3] as String,
      judulTI: fields[4] as String,
      namaMobil: fields[5] as String,
      nomorTI: fields[1] as String,
      publishedDate: fields[0] as String,
      idUrl: fields[6] as String,
      cookiesWeb: (fields[7] as Map).cast<String, String>(),
      headers: (fields[8] as Map).cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TechnicalModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.publishedDate)
      ..writeByte(1)
      ..write(obj.nomorTI)
      ..writeByte(3)
      ..write(obj.forDealer)
      ..writeByte(4)
      ..write(obj.judulTI)
      ..writeByte(5)
      ..write(obj.namaMobil)
      ..writeByte(6)
      ..write(obj.idUrl)
      ..writeByte(7)
      ..write(obj.cookiesWeb)
      ..writeByte(8)
      ..write(obj.headers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TechnicalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
