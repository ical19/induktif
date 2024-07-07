// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:induktif/domain/model/technical_model.dart';
import 'package:induktif/domain/network/technical_network.dart';
import 'package:induktif/view/primer/myapp.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

part 'list_event.dart';
part 'list_state.dart';

class TechInfoBloc extends Bloc<TechInfoEvent, TechInfoState> {
  TechInfoBloc() : super(TechInfoUninitialized()) {
    on<TechInfoEvent>((event, emit) async {
      Box infoTeknis = await Hive.openBox("info_teknis");
      List<TechnicalModel> techMo = [];
      List<TechnicalModel> techMod = [];
      int timeout = 200;
      var values = TechnicalModel(
          headers: {},
          publishedDate: '0',
          nomorTI: '0',
          forDealer: '0',
          judulTI: '0',
          namaMobil: '0',
          idUrl: '',
          cookiesWeb: {});
      techMod.add(values);
      MyApp mainPage = const MyApp();

      TechnicalNetwork technicalNetwork = TechnicalNetwork();
      Uri loginTI = Uri(
          scheme: 'https',
          host: 'd28000000bxxiea2.my.site.com',
          path: '/partners/jslibrary/SfdcSessionBase208.js');
      if (state is TechInfoUninitialized) {
        try {
          if (infoTeknis.length != 0) {
            var jml = infoTeknis.length;
            for (var i = 0; i < jml; i++) {
              techMo.add(infoTeknis.getAt(i));
            }
            emit(TechInfoLoaded(technicalModel: techMo));
          } else {
            http.Response response =
                await http.get(loginTI).timeout(Duration(seconds: timeout));
            if (response.statusCode == 200) {
              var value = await technicalNetwork.getInfoTI();
              techMo.addAll(value);
              emit(TechInfoLoaded(technicalModel: techMo));
            } else {
              emit(TechInfoLoaded(
                  technicalModel: techMod,
                  pesan: const Text('404 Not Found!')));
            }
          }
        } on TimeoutException {
          mainPage.listTechnicalModel = List.from(techMod);
          emit(TechInfoLoaded(
              technicalModel: techMod,
              pesan: const Text('Waktu koneksi >200 s')));
        } on SocketException {
          mainPage.listTechnicalModel = List.from(techMod);
          emit(TechInfoLoaded(
              technicalModel: techMod,
              pesan: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_off,
                    size: 40,
                    color: Colors.blueGrey[800],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Tidak ada jaringan')
                ],
              )));
        } on Error {
          mainPage.listTechnicalModel = List.from(techMod);
          emit(TechInfoLoaded(
              technicalModel: techMod, pesan: const Text('Data invalid.')));
        }
      } else {
        emit(TechInfoLoaded(
          technicalModel: techMod,
          childApp: LoadingAnimationWidget.waveDots(
              color: InduktifTheme.nearlyBlack, size: 45),
        ));
        try {
          http.Response response =
              await http.get(loginTI).timeout(Duration(seconds: timeout));
          if (response.statusCode == 200) {
            var value = await technicalNetwork.getInfoTI();
            techMo.addAll(value);
            emit(TechInfoLoaded(technicalModel: techMo));
          } else {
            var value = await technicalNetwork.getInfoTI();
            techMo.addAll(value);
            emit(TechInfoLoaded(
                technicalModel: techMod, pesan: const Text('404 Not Found!')));
          }
        } on TimeoutException {
          emit(TechInfoLoaded(
              technicalModel: techMod,
              pesan: const Text('Server bermasalah.')));
        } on SocketException {
          emit(TechInfoLoaded(
              technicalModel: techMod,
              pesan: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_off,
                    size: 40,
                    color: Colors.blueGrey[800],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Tidak ada jaringan')
                ],
              )));
        } on Error {
          emit(TechInfoLoaded(
              technicalModel: techMod, pesan: const Text('Data invalid.')));
        }
      }
    });
  }
}
