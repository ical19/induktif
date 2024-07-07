// ignore_for_file: prefer_is_empty
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:induktif/domain/model/technical_model_detail.dart';

class PostSecond extends StatelessWidget {
  final TechnicalModelDetail? technicalModelDetail;
  final Widget? content;
  const PostSecond({Key? key, this.technicalModelDetail, this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String>? urlGambar = [];
    Map<String, String>? cookies = technicalModelDetail?.detHeaderPict;

    if (technicalModelDetail?.detNomorTI != '0') {
      var document = technicalModelDetail!.detail;

      var elementGambarKondisi = document!.getElementsByTagName('img');
      var banyakGambarKondisi = (document.outerHtml.contains('img'))
          ? elementGambarKondisi.length
          : 0;

      if (banyakGambarKondisi > 0) {
        for (int i = 0; i < banyakGambarKondisi; i++) {
          if (elementGambarKondisi[i].outerHtml.contains('partners/servlet')) {
            var ambilLink = (elementGambarKondisi[i]
                    .outerHtml
                    .contains('<img alt="" src="/'))
                ? elementGambarKondisi[i]
                    .outerHtml
                    .replaceAll(
                        '<img alt="" src="/', '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com/')
                    .replaceAll('&amp;', '&')
                : (elementGambarKondisi[i].outerHtml.contains('<img src="/'))
                    ? elementGambarKondisi[i]
                        .outerHtml
                        .replaceAll(
                            '<img src="/', '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com/')
                        .replaceAll('&amp;', '&')
                    : (elementGambarKondisi[i]
                            .outerHtml
                            .contains('<img data-lazy-src="'))
                        ? elementGambarKondisi[i]
                            .outerHtml
                            .replaceAll('<img data-lazy-src="',
                                '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com/')
                            .replaceAll('&amp;', '&')
                        : (elementGambarKondisi[i]
                                .outerHtml
                                .contains('<img alt="" src="http'))
                            ? elementGambarKondisi[i]
                                .outerHtml
                                .replaceAll('<img alt="" src="http',
                                    '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com/')
                                .replaceAll('&amp;', '&')
                            : (elementGambarKondisi[i]
                                    .outerHtml
                                    .contains('<img src="http'))
                                ? elementGambarKondisi[i]
                                    .outerHtml
                                    .replaceAll('<img src="http', '<img alt="[Ini adalah gambar yang tidak ditampilkan, klik teks ini untuk membukanya]" src="https://d28000000bxxiea2.my.site.com/')
                                    .replaceAll('&amp;', '&')
                                : elementGambarKondisi[i].outerHtml.replaceAll('<img', '<a').replaceAll('&amp;', '&');
            var linkAja = ambilLink.split('"')[3];
            urlGambar.add(linkAja);
          }
        }
      }
    }

    final levelIndicator = Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: LinearProgressIndicator(
          backgroundColor: Colors.white,
          value: 3,
          valueColor: AlwaysStoppedAnimation(Colors.grey[350])),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: Center(
        child: Text(
          technicalModelDetail!.detStatusDok!,
          style: TextStyle(color: Colors.greenAccent[400]),
        ),
      ),
    );

    final coursePriceEmpty = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: const Center(
        child: Text(
          '[ -- ]',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );

    final topContentText = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (MediaQuery.of(context).size.width < 420)
            ? <Widget>[
                Text(
                  technicalModelDetail!.detJudulDokumen!,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 1, child: levelIndicator),
                    Expanded(
                        flex: 6,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'oleh ${technicalModelDetail!.detOwner}',
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
                  technicalModelDetail!.detJudulDokumen!,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 1, child: levelIndicator),
                    Expanded(
                        flex: 6,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'oleh ${technicalModelDetail!.detOwner}',
                              style: const TextStyle(color: Colors.white),
                            ))),
                    Expanded(flex: 3, child: coursePrice)
                  ],
                )
              ]);

    final topContentTextEmpty = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // SizedBox(height: 10.0),
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
        const Text(
          '[no text to show, empty result]',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        const SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            const Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      '[ -- ]',
                      style: TextStyle(color: Colors.white),
                    ))),
            Expanded(flex: 3, child: coursePriceEmpty)
          ],
        ),
      ],
    );

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
          decoration: const BoxDecoration(
              color: InduktifTheme.lightText,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Center(
            child: (technicalModelDetail!.detNomorTI == '0')
                ? SingleChildScrollView(child: topContentTextEmpty)
                : SingleChildScrollView(child: topContentText),
          ),
        ),
      ],
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    icon: const Icon(Icons.info_outline), onPressed: () {})
              ],
              expandedHeight: MediaQuery.of(context).size.height * 0.3,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(technicalModelDetail!.detNomorTI!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: topContent),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: (technicalModelDetail!.detNomorTI == '0')
                              ? const SizedBox()
                              : const CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 15),
                        content!,
                        (urlGambar.length > 0)
                            ? Column(
                                children:
                                    List.generate(urlGambar.length, (cuk) {
                                  return SizedBox(
                                      width: 0,
                                      height: 0,
                                      child: CachedNetworkImage(
                                        imageUrl: urlGambar[cuk],
                                        httpHeaders: cookies,
                                        filterQuality: FilterQuality.high,
                                      ));
                                }),
                              )
                            : const SizedBox(
                                height: 1,
                              )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
