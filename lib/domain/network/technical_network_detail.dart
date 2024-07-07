import 'package:hive/hive.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:induktif/domain/model/tm_saved_detail.dart';
import 'package:requests/requests.dart';
import 'package:induktif/domain/model/technical_model_detail.dart';

class TechnicalNetworkDetail {
  final String? idDetailLink;
  final Map<String, String>? headersDetailLink;
  final Map<String, String>? cookiesWeb;

  TechnicalNetworkDetail(
      {this.headersDetailLink, this.idDetailLink, this.cookiesWeb});

  Future<List<TechnicalModelDetail>> getDetailInfo() async {
    List<TechnicalModelDetail> technicalDetail = [];
    List<TMSavedDetail> savedTechnicalDetail = [];
    Box infoTeknisDetail = Hive.box('info_teknis_detail');

    var detailRequest = await Requests.get(
      'https://d28000000bxxiea2.my.site.com/partners/apex/TI_Bulletin?id=$idDetailLink&action=detail',
      headers: headersDetailLink,
    );

    var detail = parse(detailRequest.content());
    var tdDetail = detail.getElementsByTagName('td');
    var trDetail = detail.getElementsByTagName('tr');

    String doBruteForceText(
        {List<Element>? isiContent, int? mKataKunci, String? kataKunci}) {
      List<String> textPage = [];
      for (int i = 0; i < 11; i++) {
        if (isiContent![mKataKunci! + i]
            .outerHtml
            .toLowerCase()
            .contains((kataKunci!.toLowerCase()))) {
          if (isiContent[mKataKunci + i].outerHtml.contains('img')) {
            (isiContent[mKataKunci + i].outerHtml.contains('<img alt="" src="'))
                ? textPage.add(isiContent[mKataKunci + i]
                    .outerHtml
                    .replaceAll('<img alt="" src="',
                        '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com')
                    .replaceAll('&amp;', '&'))
                : (isiContent[mKataKunci + i].outerHtml.contains('<img src="/'))
                    ? textPage.add(isiContent[mKataKunci + i]
                        .outerHtml
                        .replaceAll('<img src="/',
                            '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com/')
                        .replaceAll('&amp;', '&'))
                    : textPage.add(isiContent[mKataKunci + i]
                        .outerHtml
                        .replaceAll('<img src="http',
                            '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="http')
                        .replaceAll('&amp;', '&'));
          } else {
            textPage.add(isiContent[mKataKunci + i].outerHtml);
          }
        } else {}
      }
      return textPage[0];
    }

    String doBackgroundText({Element? isiContent}) {
      var result = (isiContent!.outerHtml.contains('img'))
          ? (isiContent.outerHtml.contains('<img alt="" src="'))
              ? isiContent.outerHtml
                  .replaceAll('<img alt="" src="',
                      '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com')
                  .replaceAll('&amp;', '&')
              : (isiContent.outerHtml.contains('<img src="/'))
                  ? isiContent.outerHtml
                      .replaceAll('<img src="/',
                          '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com')
                      .replaceAll('&amp;', '&')
                  : isiContent.outerHtml
                      .replaceAll('<img src="http',
                          '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="htt')
                      .replaceAll('&amp;', '&')
          : isiContent.outerHtml;
      return result;
    }

    String detBackground = doBackgroundText(isiContent: trDetail.toList()[13]);

    String detKondisi = doBruteForceText(
      isiContent: trDetail.toList(),
      mKataKunci: 15,
      kataKunci: '>Kondisi Problem / gejala<',
    );

    String detPenyebabPro = doBruteForceText(
      isiContent: trDetail.toList(),
      mKataKunci: 17,
      kataKunci: '>Penyebab Problem<',
    );

    String detLangkahPer = doBruteForceText(
      isiContent: trDetail.toList(),
      mKataKunci: 18,
      kataKunci: '>Langkah Perbaikan / Field Fix<',
    );

    String detPermintaan = doBruteForceText(
      isiContent: trDetail.toList(),
      mKataKunci: 18,
      kataKunci: '>Permintaan<',
    );

    String detInfoCounter = doBruteForceText(
      isiContent: trDetail.toList(),
      mKataKunci: 18,
      kataKunci: '>Informasi Countermeasure<',
    );

    var finalResult = TechnicalModelDetail(
        detJudulDokumen: tdDetail[4].text,
        detNomorTI: tdDetail[5].text,
        detStatusDok: tdDetail[6].text,
        detModel: tdDetail[7].outerHtml,
        detOwner: tdDetail[8].text,
        detNamaModel: tdDetail[9].outerHtml,
        detRecordType: tdDetail[10].outerHtml,
        detPartNameUtama: tdDetail[11].outerHtml,
        detTanggalPub: tdDetail[12].outerHtml,
        detPartNumberUtama: tdDetail[13].outerHtml,
        detPartNameTamb: tdDetail[14].outerHtml,
        detPartNumberTamb: tdDetail[15].outerHtml,
        detKomponen: tdDetail[23].outerHtml,
        detKategKomp: tdDetail[22].outerHtml,
        detKodeT1: tdDetail[24].outerHtml,
        detBackground: trDetail.toList(), //13
        detKondisi: trDetail.toList(),
        detPenyebabPro: trDetail.toList(),
        detLangkahPer: trDetail.toList(), //20
        detPermintaan: trDetail.toList(), //22
        detInfoCounter: trDetail.toList(),
        detHeaderPict: cookiesWeb,
        detail: detail);

    technicalDetail.add(finalResult);

    var finalSavedResult = TMSavedDetail(
      detKondisi: detKondisi,
      detLangkahPer: detLangkahPer,
      detPenyebabPro: detPenyebabPro,
      detPermintaan: detPermintaan,
      pathImage: '',
      detBackground: detBackground,
      detHeaderPict: cookiesWeb,
      detInfoCounter: detInfoCounter,
      detJudulDokumen: tdDetail[4].text,
      detNomorTI: tdDetail[5].text,
      detStatusDok: tdDetail[6].text,
      detModel: tdDetail[7].outerHtml,
      detOwner: tdDetail[8].text,
      detNamaModel: tdDetail[9].outerHtml,
      detRecordType: tdDetail[10].outerHtml,
      detPartNameUtama: tdDetail[11].outerHtml,
      detTanggalPub: tdDetail[12].outerHtml,
      detPartNumberUtama: tdDetail[13].outerHtml,
      detPartNameTamb: tdDetail[14].outerHtml,
      detPartNumberTamb: tdDetail[15].outerHtml,
      detKomponen: tdDetail[23].outerHtml,
      detKategKomp: tdDetail[22].outerHtml,
      detKodeT1: tdDetail[24].outerHtml,
    ); //save to Hive database

    savedTechnicalDetail.add(finalSavedResult);
    infoTeknisDetail.put(idDetailLink, finalSavedResult);
    return technicalDetail;
  }
}
