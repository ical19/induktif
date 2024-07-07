import 'package:html/dom.dart';
import 'package:hive/hive.dart';
part 'technical_model_detail.g.dart';

@HiveType(typeId: 2)
class TechnicalModelDetail {
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
  List<Element>? detBackground;

  @HiveField(16)
  List<Element>? detKondisi;

  @HiveField(17)
  List<Element>? detPenyebabPro;

  @HiveField(18)
  List<Element>? detLangkahPer;

  @HiveField(19)
  List<Element>? detPermintaan;

  @HiveField(20)
  List<Element>? detInfoCounter;

  @HiveField(21)
  Map<String, String>? detHeaderPict;

  @HiveField(22)
  Document? detail;

  TechnicalModelDetail(
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
      this.detail});
}
