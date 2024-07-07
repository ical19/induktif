// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'technical_model_detail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TechnicalModelDetailAdapter extends TypeAdapter<TechnicalModelDetail> {
  @override
  final int typeId = 2;

  @override
  TechnicalModelDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TechnicalModelDetail(
      detBackground: (fields[15] as List?)?.cast<Element>(),
      detInfoCounter: (fields[20] as List?)?.cast<Element>(),
      detJudulDokumen: fields[0] as String?,
      detKategKomp: fields[12] as String?,
      detKodeT1: fields[14] as String?,
      detKomponen: fields[13] as String?,
      detKondisi: (fields[16] as List?)?.cast<Element>(),
      detPenyebabPro: (fields[17] as List?)?.cast<Element>(),
      detLangkahPer: (fields[18] as List?)?.cast<Element>(),
      detModel: fields[2] as String?,
      detNamaModel: fields[3] as String?,
      detNomorTI: fields[1] as String?,
      detOwner: fields[7] as String?,
      detPartNameTamb: fields[10] as String?,
      detPartNameUtama: fields[4] as String?,
      detPartNumberUtama: fields[5] as String?,
      detPartNumberTamb: fields[11] as String?,
      detPermintaan: (fields[19] as List?)?.cast<Element>(),
      detRecordType: fields[8] as String?,
      detStatusDok: fields[6] as String?,
      detTanggalPub: fields[9] as String?,
      detHeaderPict: (fields[21] as Map?)?.cast<String, String>(),
      detail: fields[22] as Document?,
    );
  }

  @override
  void write(BinaryWriter writer, TechnicalModelDetail obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.detJudulDokumen)
      ..writeByte(1)
      ..write(obj.detNomorTI)
      ..writeByte(2)
      ..write(obj.detModel)
      ..writeByte(3)
      ..write(obj.detNamaModel)
      ..writeByte(4)
      ..write(obj.detPartNameUtama)
      ..writeByte(5)
      ..write(obj.detPartNumberUtama)
      ..writeByte(6)
      ..write(obj.detStatusDok)
      ..writeByte(7)
      ..write(obj.detOwner)
      ..writeByte(8)
      ..write(obj.detRecordType)
      ..writeByte(9)
      ..write(obj.detTanggalPub)
      ..writeByte(10)
      ..write(obj.detPartNameTamb)
      ..writeByte(11)
      ..write(obj.detPartNumberTamb)
      ..writeByte(12)
      ..write(obj.detKategKomp)
      ..writeByte(13)
      ..write(obj.detKomponen)
      ..writeByte(14)
      ..write(obj.detKodeT1)
      ..writeByte(15)
      ..write(obj.detBackground)
      ..writeByte(16)
      ..write(obj.detKondisi)
      ..writeByte(17)
      ..write(obj.detPenyebabPro)
      ..writeByte(18)
      ..write(obj.detLangkahPer)
      ..writeByte(19)
      ..write(obj.detPermintaan)
      ..writeByte(20)
      ..write(obj.detInfoCounter)
      ..writeByte(21)
      ..write(obj.detHeaderPict)
      ..writeByte(22)
      ..write(obj.detail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TechnicalModelDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
