// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:induktif/domain/model/searching_model.dart';
import 'package:induktif/view/seconder/myapp/technical_information_detail.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class SearchResult extends StatefulWidget {
  final SearchingModel? model;
  final int? nomorUrut;
  const SearchResult({super.key, this.nomorUrut, this.model});

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    String idUrl = widget.model!.idLinkJudul!.split('?')[0];
    Map<String, String>? cookiesWeb = widget.model!.cookiesWeb;
    Map<String, String>? headers = widget.model!.headers;

    return Material(
      child: ListTile(
        tileColor: InduktifTheme.spacer,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TechnicalInformationDetail(
                        idUrl: idUrl,
                        cookiesWeb: cookiesWeb,
                        headers: headers,
                      )));
        },
        title: Text(
          widget.model!.judul!.substring(0, 11),
          style: InduktifTheme.title,
        ),
        subtitle: Text(
          '${widget.model!.judul!.substring(11).capitalize()}..',
          style:
              InduktifTheme.subtitle.copyWith(color: InduktifTheme.nearlyBlack),
        ),
      ),
    ); //listtile
  }
}
