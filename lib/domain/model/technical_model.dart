import 'package:hive/hive.dart';
part 'technical_model.g.dart';


@HiveType(typeId: 1)
class TechnicalModel {
  @HiveField(0)
  String publishedDate;

  @HiveField(1)
  String nomorTI;

  @HiveField(3)
  String forDealer;

  @HiveField(4)
  String judulTI;

  @HiveField(5)
  String namaMobil;

  @HiveField(6)
  String idUrl;

  @HiveField(7)
  Map<String, String> cookiesWeb;

  @HiveField(8)
  Map<String, String> headers;

  TechnicalModel(
      {required this.forDealer,
      required this.judulTI,
      required this.namaMobil,
      required this.nomorTI,
      required this.publishedDate,
      required this.idUrl,
      required this.cookiesWeb,
      required this.headers});
}
