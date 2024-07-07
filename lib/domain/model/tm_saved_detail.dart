import 'package:hive/hive.dart';
part 'tm_saved_detail.g.dart';

@HiveType(typeId: 2)
class TMSavedDetail {
  @HiveField(0)
  String? detJudulDokumen;

  @HiveField(1)
  String? detNomorTI;

  @HiveField(2)
  String? detModel;

  @HiveField(3)
  String? detNamaModel;

  @HiveField(4)
  String? detPartNameUtama;

  @HiveField(5)
  String? detPartNumberUtama;

  @HiveField(6)
  String? detStatusDok;

  @HiveField(7)
  String? detOwner;

  @HiveField(8)
  String? detRecordType;

  @HiveField(9)
  String? detTanggalPub;

  @HiveField(10)
  String? detPartNameTamb;

  @HiveField(11)
  String? detPartNumberTamb;

  @HiveField(12)
  String? detKategKomp;

  @HiveField(13)
  String? detKomponen;

  @HiveField(14)
  String? detKodeT1;

  @HiveField(15)
  String? detBackground;

  @HiveField(16)
  String? detKondisi;

  @HiveField(17)
  String? detPenyebabPro;

  @HiveField(18)
  String? detLangkahPer;

  @HiveField(19)
  String? detPermintaan;

  @HiveField(20)
  String? detInfoCounter;

  @HiveField(21)
  Map<String, String>? detHeaderPict;

  @HiveField(22)
  String? pathImage;

  TMSavedDetail(
      {this.detBackground,
      this.detInfoCounter,
      this.detJudulDokumen,
      this.detKategKomp,
      this.detKodeT1,
      this.detKomponen,
      this.detKondisi,
      this.detPenyebabPro,
      this.detLangkahPer,
      this.detModel,
      this.detNamaModel,
      this.detNomorTI,
      this.detOwner,
      this.detPartNameTamb,
      this.detPartNameUtama,
      this.detPartNumberUtama,
      this.detPartNumberTamb,
      this.detPermintaan,
      this.detRecordType,
      this.detStatusDok,
      this.detTanggalPub,
      this.detHeaderPict,
      this.pathImage});
}
