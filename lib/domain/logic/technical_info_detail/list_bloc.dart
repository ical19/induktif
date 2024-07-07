// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:induktif/domain/model/technical_model_detail.dart';
import 'package:induktif/domain/network/technical_network_detail.dart';

part 'list_event.dart';
part 'list_state.dart';

class TechInfoDetBloc extends Bloc<TechInDetEvent, TechInDetState> {
  TechInfoDetBloc(TechInDetState initialState) : super(initialState) {
    on<TechInDetEvent>((event, emit) async {
      TechnicalNetworkDetail technicalNetworkDetail = TechnicalNetworkDetail(
          idDetailLink: event.idUrl,
          headersDetailLink: event.headers,
          cookiesWeb: event.cookiesWeb);

      List<TechnicalModelDetail> techModUninitialized = [];
      var values = TechnicalModelDetail(
          detBackground: [],
          detHeaderPict: {},
          detInfoCounter: [],
          detJudulDokumen: '0',
          detKategKomp: '0',
          detKodeT1: '0',
          detKomponen: '0',
          detKondisi: [],
          detLangkahPer: [],
          detModel: '0',
          detNamaModel: '0',
          detNomorTI: '0',
          detOwner: '0',
          detPartNameTamb: '0',
          detPartNameUtama: '0',
          detPartNumberTamb: '0',
          detPartNumberUtama: '0',
          detPenyebabPro: [],
          detPermintaan: [],
          detRecordType: '0',
          detStatusDok: '0',
          detTanggalPub: '0');
      techModUninitialized.add(values);
      List<TechnicalModelDetail> loaded = [];

      var timeout = 200;
      Uri loginTI = Uri(
          scheme: 'https',
          host: 'd28000000bxxiea2.my.site.com',
          path: '/partners/login');

      if (state is TechInDetUninitialized) {
        try {
          http.Response response =
              await http.get(loginTI).timeout(Duration(seconds: timeout));
          if (response.statusCode == 200) {
            var techDet = await technicalNetworkDetail.getDetailInfo();
            emit(TechInDetSecond(technicalModelDetail: techDet));
          } else {
            emit(TechInDetSecond(
                technicalModelDetail: techModUninitialized,
                pesan: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.portable_wifi_off_rounded,
                      size: 40,
                      color: Colors.blueGrey[800],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('404 not found.')
                  ],
                )));
          }
        } on TimeoutException {
          emit(TechInDetSecond(
              technicalModelDetail: techModUninitialized,
              pesan: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.portable_wifi_off_rounded,
                    size: 40,
                    color: Colors.blueGrey[800],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Timeout has been reached, refresh the page.')
                ],
              )));
        } on SocketException {
          emit(TechInDetSecond(
              technicalModelDetail: techModUninitialized,
              pesan: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_off,
                    size: 25,
                    color: Colors.blueGrey[800],
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  const Text(
                    'No network',
                    style: TextStyle(fontSize: 10),
                  )
                ],
              )));
        } on Error {
          emit(TechInDetSecond(
              technicalModelDetail: techModUninitialized,
              pesan: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.portable_wifi_off_rounded,
                    size: 40,
                    color: Colors.blueGrey[800],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Data invalid, contact developer.')
                ],
              )));
        }
      } else if (state is TechInDetSecond) {
        try {
          http.Response response =
              await http.get(loginTI).timeout(Duration(seconds: timeout));
          if (response.statusCode == 200) {
            var techDet = await technicalNetworkDetail.getDetailInfo();
            loaded.addAll(techDet);
            emit(TechInDetLoaded(technicalModelDetail: techDet));
          } else {
            emit(TechInDetSecond(
                technicalModelDetail: techModUninitialized,
                pesan: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.portable_wifi_off_rounded,
                      size: 40,
                      color: Colors.blueGrey[800],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('404 not found.')
                  ],
                )));
          }
        } on TimeoutException {
          emit(TechInDetSecond(
              technicalModelDetail: techModUninitialized,
              pesan:
                  const Text('Timeout has been reached, refresh the page.')));
        } on SocketException {
          emit(TechInDetSecond(
              technicalModelDetail: techModUninitialized,
              pesan: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.signal_wifi_off,
                    size: 15,
                    color: Colors.blueGrey[800],
                  ),
                  const Text('No network')
                ],
              )));
        } on Error {
          emit(TechInDetSecond(
              technicalModelDetail: techModUninitialized,
              pesan: const Text('Data invalid.')));
        }
      } else {
        try {
          emit(TechInDetLoaded(technicalModelDetail: loaded));
        } on Error {
          emit(TechInDetLoaded(
            technicalModelDetail: loaded,
          ));
        }
      }
    });
  }
}
