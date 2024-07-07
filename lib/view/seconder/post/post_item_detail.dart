// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:induktif/domain/model/technical_model_detail.dart';
import 'package:induktif/view/seconder/myapp/detil_image.dart';
import 'package:flutter_html/flutter_html.dart';

class PostItemDetail extends StatefulWidget {
  final TechnicalModelDetail? technicalModelDetail;
  const PostItemDetail({Key? key, this.technicalModelDetail}) : super(key: key);

  @override
  _PostItemDetailState createState() => _PostItemDetailState();
}

class _PostItemDetailState extends State<PostItemDetail> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    const levelIndicator = LinearProgressIndicator(
        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
        value: 3,
        valueColor: AlwaysStoppedAnimation(Colors.green));

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Center(
        child: Text(
          widget.technicalModelDetail!.detStatusDok!,
          style: TextStyle(color: Colors.greenAccent[400]),
        ),
      ),
    );

    final topContentText = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (MediaQuery.of(context).size.width < 420)
            ? <Widget>[
                Text(
                  widget.technicalModelDetail!.detJudulDokumen!,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Expanded(flex: 1, child: levelIndicator),
                    Expanded(
                        flex: 6,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'oleh ${widget.technicalModelDetail!.detOwner!}',
                              style: const TextStyle(color: Colors.white),
                            ))),
                    Expanded(flex: 3, child: coursePrice)
                  ],
                ),
              ]
            : <Widget>[
                const Icon(
                  Icons.directions_car,
                  color: Colors.white,
                  size: 40.0,
                ),
                const SizedBox(
                  width: 90.0,
                  child: Divider(color: Colors.green),
                ),
                const SizedBox(height: 10.0),
                Text(
                  widget.technicalModelDetail!.detJudulDokumen!,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Expanded(flex: 1, child: levelIndicator),
                    Expanded(
                        flex: 6,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'oleh ${widget.technicalModelDetail!.detOwner!}',
                              style: const TextStyle(color: Colors.white),
                            ))),
                    Expanded(flex: 3, child: coursePrice)
                  ],
                )
              ]);

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    'https://raw.githubusercontent.com/shubie/Beautiful-List-UI-and-detail-page/master/assets/drive-steering-wheel.jpg'),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          padding: const EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Center(
            child: SingleChildScrollView(child: topContentText),
          ),
        ),
      ],
    );

    final bottomContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BottomContent(
          isiContent: widget.technicalModelDetail!.detBackground?[13],
          namaContent: 'Background',
        ),
        BottomContentList(
          cookies: widget.technicalModelDetail!.detHeaderPict!,
          isiContent: widget.technicalModelDetail!.detKondisi!,
          namaContent: 'Kondisi Problem / gejala',
          mKataKunci: 15,
          kataKunci: '>Kondisi Problem / gejala<',
        ),
        BottomContentList(
          cookies: widget.technicalModelDetail!.detHeaderPict!,
          isiContent: widget.technicalModelDetail!.detPenyebabPro!,
          mKataKunci: 17,
          kataKunci: '>Penyebab Problem<',
          namaContent: 'Penyebab problem :',
        ),
        BottomContentList(
          isiContent: widget.technicalModelDetail!.detLangkahPer!,
          mKataKunci: 18,
          kataKunci: '>Langkah Perbaikan / Field Fix<',
          namaContent: 'Langkah perbaikan/field fix :',
        ),
        BottomContentList(
          isiContent: widget.technicalModelDetail!.detPermintaan!,
          mKataKunci: 18,
          kataKunci: '>Permintaan<',
          namaContent: 'Permintaan :',
        ),
        BottomContentList(
          cookies: widget.technicalModelDetail!.detHeaderPict!,
          isiContent: widget.technicalModelDetail!.detInfoCounter!,
          mKataKunci: 18,
          kataKunci: '>Informasi Countermeasure<',
          namaContent: 'Info countermeasure :',
        ),
      ],
    );
    final readButton = TitleContent(
      lebar: 150,
      namaContent: 'Fix error',
      functionContent: () {
        setState(() {});
      },
      warnaDasar: Colors.lightBlueAccent,
    );
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding:
          const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 0.0, top: 0.0),
      child: Column(
        children: [bottomContentText, readButton],
      ),
    );

    return Scaffold(
      key: scaffoldKey,
      drawer: contentDrawer(
          detKategKomp: widget.technicalModelDetail!.detKategKomp!,
          detKodeT1: widget.technicalModelDetail!.detKodeT1!,
          detKomponen: widget.technicalModelDetail!.detKomponen!,
          namaModel: widget.technicalModelDetail!.detModel!,
          model: widget.technicalModelDetail!.detModel!,
          partNumbTambahan: widget.technicalModelDetail!.detPartNumberTamb!,
          partNumbUtama: widget.technicalModelDetail!.detPartNumberUtama!,
          partnameTambahan: widget.technicalModelDetail!.detPartNameTamb!,
          partnameUtama: widget.technicalModelDetail!.detPartNameTamb!,
          recordType: widget.technicalModelDetail!.detRecordType!,
          tanggalPublish: widget.technicalModelDetail!.detTanggalPub!,
          context: context,
          technicalModelDetail: widget.technicalModelDetail!),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30))),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      scaffoldKey.currentState!.openDrawer();
                    })
              ],
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(widget.technicalModelDetail!.detNomorTI!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: topContent),
            ),
          ];
        },
        body: Stack(children: [
          SingleChildScrollView(child: bottomContent),
          // Center(
          //   child: Align(
          //       alignment: Alignment.bottomCenter,
          //       child: AdmobBanner(
          //         adUnitId: 'ca-app-pub-8216246119562982/2629436686',
          //         adSize: AdmobBannerSize.BANNER,
          //       )),
          // )
        ]),
      ),
    );
  }
}

ImageRender cachedNetworkImage({
  Map<String, String>? cookiesImage,
}) =>
    (context, attributes, element) {
      return CachedNetworkImage(
        imageUrl: attributes["src"]!,
        httpHeaders: cookiesImage,
      );
    };

class BottomContentList extends StatelessWidget {
  const BottomContentList({
    Key? key,
    this.namaContent,
    this.isiContent,
    this.functionContent,
    this.cookies,
    this.kataKunci,
    this.mKataKunci,
  }) : super(key: key);

  final Map<String, String>? cookies;
  final List<dom.Element>? isiContent;
  final String? namaContent;
  final Function()? functionContent;
  final String? kataKunci;
  final int? mKataKunci;

  @override
  Widget build(BuildContext context) {
    List<String> textPage = [];
    for (int i = 0; i < 11; i++) {
      if (isiContent![mKataKunci! + i]
          .outerHtml
          .toLowerCase()
          .contains((kataKunci!.toLowerCase()))) {
        if (isiContent![mKataKunci! + i].outerHtml.contains('img')) {
          (isiContent![mKataKunci! + i].outerHtml.contains('<img alt="" src="'))
              ? textPage.add(isiContent![mKataKunci! + i]
                  .outerHtml
                  .replaceAll('<img alt="" src="',
                      '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com')
                  .replaceAll('&amp;', '&'))
              : (isiContent![mKataKunci! + i].outerHtml.contains('<img src="/'))
                  ? textPage.add(isiContent![mKataKunci! + i]
                      .outerHtml
                      .replaceAll('<img src="/',
                          '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com/')
                      .replaceAll('&amp;', '&'))
                  : textPage.add(isiContent![mKataKunci! + i]
                      .outerHtml
                      .replaceAll('<img src="http',
                          '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="http')
                      .replaceAll('&amp;', '&'));
        } else {
          textPage.add(isiContent![mKataKunci! + i].outerHtml);
        }
      } else {}
    }

    void redirectTo(String url, Map<String, String> cookiest) {
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return DetailScreen(
          cookies: cookiest,
          url: url,
        );
      }));
    }

    return Column(
      children: [
        TitleContent(
          functionContent: functionContent,
          namaContent: namaContent,
          warnaDasar: InduktifTheme.lightText,
        ),
        Html(
            data: textPage[0]
                .replaceAll('table', 'span')
                .replaceAll(kataKunci!, '><'),
            style: {'span': Style(color: Theme.of(context).hintColor)},
            onImageTap: (url, renderContext, mapString, element) {
              return redirectTo(url!, cookies!);
            },
            customImageRenders: {
              networkSourceMatcher(schemas: ['https', 'http']):
                  cachedNetworkImage(cookiesImage: cookies)
            })
      ],
    );
  }
}

class BottomContent extends StatelessWidget {
  const BottomContent({
    Key? key,
    this.namaContent,
    this.isiContent,
    this.functionContent,
  }) : super(key: key);

  final dom.Element? isiContent;
  final String? namaContent;
  final Function()? functionContent;
  @override
  Widget build(BuildContext context) {
    var result = (isiContent!.outerHtml.contains('img'))
        ? (isiContent!.outerHtml.contains('<img alt="" src="'))
            ? isiContent!.outerHtml
                .replaceAll('<img alt="" src="',
                    '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com')
                .replaceAll('&amp;', '&')
            : (isiContent!.outerHtml.contains('<img src="/'))
                ? isiContent!.outerHtml
                    .replaceAll('<img src="/',
                        '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com')
                    .replaceAll('&amp;', '&')
                : isiContent!.outerHtml
                    .replaceAll('<img src="http',
                        '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="htt')
                    .replaceAll('&amp;', '&')
        : isiContent!.outerHtml;

    return Column(
      children: [
        TitleContent(
            functionContent: functionContent,
            namaContent: namaContent,
            warnaDasar: Colors.lightBlueAccent),
        Html(
          data: result
              .replaceAll('table', 'span')
              .replaceAll('>Background<', '><'),
          style: {'span': Style(color: Theme.of(context).hintColor)},
        ),
      ],
    );
  }
}

class TitleContent extends StatelessWidget {
  final String? namaContent;
  final Function()? functionContent;
  final Color? warnaDasar;
  final double? lebar;
  final Function()? functionRefresh;

  const TitleContent({
    this.warnaDasar,
    this.functionContent,
    this.functionRefresh,
    this.namaContent,
    Key? key,
    this.lebar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        width: (lebar != null) ? lebar : MediaQuery.of(context).size.width,
        child: ElevatedButton(
            onPressed: functionContent,
            child: (lebar != null)
                ? Text(namaContent!,
                    style: const TextStyle(color: Colors.white))
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(namaContent!,
                          style: const TextStyle(color: Colors.white)),
                      IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: functionRefresh)
                    ],
                  )));
  }
}

Widget contentDrawer(
    {String? model,
    String? namaModel,
    String? recordType,
    String? partnameUtama,
    String? partnameTambahan,
    String? tanggalPublish,
    String? partNumbUtama,
    String? partNumbTambahan,
    String? detKategKomp,
    String? detKomponen,
    String? detKodeT1,
    TechnicalModelDetail? technicalModelDetail,
    BuildContext? context}) {
  return Drawer(
    child: Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('Editor : ${technicalModelDetail!.detOwner}'),
          accountEmail: const Text("anonbt42@magenta.co"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Theme.of(context!).platform == TargetPlatform.iOS
                ? Colors.lightBlueAccent
                : Colors.white,
            child: const Text(
              "M",
              style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        Expanded(
          child: ListView(children: [
            ListTile(
              leading: const Icon(Icons.car_repair),
              subtitle: Html(data: model),
              title: const Text('Model Kendaraan'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.receipt_long_rounded),
              subtitle: Html(data: recordType),
              title: const Text('Record Type'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pages_rounded),
              subtitle: Html(data: partnameUtama),
              title: const Text('Partname utama'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pages_outlined),
              subtitle: Html(data: partnameTambahan),
              title: const Text('Partname tambahan'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.date_range_outlined),
              subtitle: Html(data: tanggalPublish),
              title: const Text('Tanggal publish'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pages_rounded),
              subtitle: Html(data: partNumbUtama),
              title: const Text('Partnumb utama'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pages_outlined),
              subtitle: Html(data: partNumbTambahan),
              title: const Text('Partnumb tambahan'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings_input_component_outlined),
              subtitle: Html(data: detKategKomp),
              title: const Text('Kategori komponen'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.details_outlined),
              subtitle: Html(data: detKomponen),
              title: const Text('Komponen'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.qr_code_sharp),
              subtitle: Html(data: detKodeT1),
              title: const Text('Kode T1'),
            ),
            const Divider(),
          ]),
        ),
      ],
    ),
  );
}
