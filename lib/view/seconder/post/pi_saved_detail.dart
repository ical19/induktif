// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:induktif/domain/model/technical_model.dart';
import 'package:induktif/domain/model/tm_saved_detail.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:induktif/view/seconder/myapp/detil_image.dart';

class PISavedDetail extends StatefulWidget {
  final TMSavedDetail? tmSavedDetail;
  final TechnicalModel? technicalModel;
  const PISavedDetail({Key? key, this.tmSavedDetail, this.technicalModel})
      : super(key: key);

  @override
  _PISavedDetailState createState() => _PISavedDetailState();
}

class _PISavedDetailState extends State<PISavedDetail> {
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
          widget.tmSavedDetail!.detStatusDok!,
          style: TextStyle(color: Colors.greenAccent[400]),
        ),
      ),
    );

    final topContentText = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (MediaQuery.of(context).size.width < 420)
            ? <Widget>[
                Text(
                  widget.tmSavedDetail!.detJudulDokumen!,
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
                              'oleh ${widget.tmSavedDetail!.detOwner!}',
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
                  widget.tmSavedDetail!.detJudulDokumen!,
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
                              'oleh ${widget.tmSavedDetail!.detOwner!}',
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
                image: NetworkImage(
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
          isiContent: widget.tmSavedDetail!.detBackground,
          namaContent: 'Background',
        ),
        BottomContentList(
          cookies: widget.technicalModel!.cookiesWeb,
          isiContent: widget.tmSavedDetail!.detKondisi!,
          namaContent: 'Kondisi Problem / gejala',
          kataKunci: '>Kondisi Problem / gejala<',
        ),
        BottomContentList(
          cookies: widget.technicalModel!.cookiesWeb,
          isiContent: widget.tmSavedDetail!.detPenyebabPro!,
          namaContent: 'Penyebab problem :',
          kataKunci: '>Penyebab Problem<',
        ),
        BottomContentList(
          cookies: widget.technicalModel!.cookiesWeb,
          isiContent: widget.tmSavedDetail!.detLangkahPer!,
          namaContent: 'Langkah perbaikan/field fix :',
          kataKunci: '>Langkah Perbaikan / Field Fix<',
        ),
        BottomContentList(
          cookies: widget.technicalModel!.cookiesWeb,
          isiContent: widget.tmSavedDetail!.detPermintaan!,
          namaContent: 'Permintaan :',
          kataKunci: '>Permintaan<',
        ),
        BottomContentList(
          cookies: widget.technicalModel!.cookiesWeb,
          isiContent: widget.tmSavedDetail!.detInfoCounter!,
          namaContent: 'Info countermeasure :',
          kataKunci: '>Informasi Countermeasure<',
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
          detKategKomp: widget.tmSavedDetail!.detKategKomp!,
          detKodeT1: widget.tmSavedDetail!.detKodeT1!,
          detKomponen: widget.tmSavedDetail!.detKomponen!,
          namaModel: widget.tmSavedDetail!.detModel!,
          model: widget.tmSavedDetail!.detModel!,
          partNumbTambahan: widget.tmSavedDetail!.detPartNumberTamb!,
          partNumbUtama: widget.tmSavedDetail!.detPartNumberUtama!,
          partnameTambahan: widget.tmSavedDetail!.detPartNameTamb!,
          partnameUtama: widget.tmSavedDetail!.detPartNameTamb!,
          recordType: widget.tmSavedDetail!.detRecordType!,
          tanggalPublish: widget.tmSavedDetail!.detTanggalPub!,
          context: context,
          tmSavedDetail: widget.tmSavedDetail!),
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
                  title: Text(widget.tmSavedDetail!.detNomorTI!,
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
  }) : super(key: key);

  final Map<String, String>? cookies;
  final String? isiContent;
  final String? namaContent;
  final String? kataKunci;
  final Function()? functionContent;

  @override
  Widget build(BuildContext context) {
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
          data: isiContent!
              .replaceAll('table', 'span')
              .replaceAll(kataKunci!, '><'),
          style: {'span': Style(color: Theme.of(context).hintColor)},
          onImageTap: (url, renderContext, mapString, element) {
            return redirectTo(url!, cookies!);
          },
          customImageRenders: {
            networkSourceMatcher(schemas: ['https', 'http']):
                cachedNetworkImage(cookiesImage: cookies)
          },
        )
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

  final String? isiContent;
  final String? namaContent;
  final Function()? functionContent;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleContent(
            functionContent: functionContent,
            namaContent: namaContent,
            warnaDasar: Colors.lightBlueAccent),
        Html(
          data: isiContent!
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
    TMSavedDetail? tmSavedDetail,
    BuildContext? context}) {
  return Drawer(
    child: Column(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text('Editor : ${tmSavedDetail!.detOwner}'),
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
