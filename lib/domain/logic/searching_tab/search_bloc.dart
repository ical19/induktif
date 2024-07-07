import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:induktif/data/theme/induktif_theme.dart';
import 'dart:io';
import 'package:induktif/domain/model/searching_model.dart';
import 'package:induktif/domain/network/searching_network.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchingBloc extends Bloc<SearchEvent, SearchState> {
  SearchingBloc() : super(SearchStarting()) {
    on<SearchEvent>((event, emit) async {
      Uri loginTI = Uri(
          scheme: 'https',
          host: 'd28000000bxxiea2.my.site.com',
          path: '/partners/jslibrary/SfdcSessionBase208.js');
      int timeout = 200;
      SearchingNetwork searchingNetwork =
          SearchingNetwork(keyWord: event.keyWord!);
      var fakeSearchlist =
          SearchingModel(idLinkJudul: "", judul: "", model: "", owner: "");
      var uninitializedList =
          SearchingModel(idLinkJudul: "empty", judul: "", model: "", owner: "");
      List<SearchingModel> tempList = [];
      List<SearchingModel> fakeList = [];
      List<SearchingModel> showFirst = [];
      showFirst.add(uninitializedList);
      fakeList.add(fakeSearchlist);
      if (state is SearchStarting) {
        emit(SearchLoaded(
          searchingModel: showFirst,
          pesan: const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: LinearProgressIndicator(
              backgroundColor: InduktifTheme.nearlyBlue,
              value: 0.2,
              minHeight: 10,
              color: InduktifTheme.darkText,
            ),
          ),
        ));
        try {
          emit(SearchLoaded(
            searchingModel: showFirst,
            pesan: const Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: LinearProgressIndicator(
                backgroundColor: InduktifTheme.nearlyBlue,
                value: 0.3,
                minHeight: 10,
                color: InduktifTheme.darkText,
              ),
            ),
          ));
          http.Response response =
              await http.get(loginTI).timeout(Duration(seconds: timeout));
          if (response.statusCode == 200) {
            emit(SearchLoaded(
              searchingModel: showFirst,
              pesan: const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: LinearProgressIndicator(
                  backgroundColor: InduktifTheme.nearlyBlue,
                  value: 0.4,
                  minHeight: 10,
                  color: InduktifTheme.darkText,
                ),
              ),
            ));
            Response? link = await searchingNetwork.loginToUrl();
            emit(SearchLoaded(
              searchingModel: showFirst,
              pesan: const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: LinearProgressIndicator(
                  backgroundColor: InduktifTheme.nearlyBlue,
                  value: 0.6,
                  minHeight: 10,
                  color: InduktifTheme.darkText,
                ),
              ),
            ));
            String? linkToken = await searchingNetwork.getLinkToken(link);
            emit(SearchLoaded(
              searchingModel: showFirst,
              pesan: const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: LinearProgressIndicator(
                  backgroundColor: InduktifTheme.nearlyBlue,
                  value: 0.9,
                  minHeight: 10,
                  color: InduktifTheme.darkText,
                ),
              ),
            ));
            var value = await searchingNetwork.getSearchResult(linkToken);
            emit(SearchLoaded(
              searchingModel: showFirst,
              pesan: const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: LinearProgressIndicator(
                  backgroundColor: InduktifTheme.nearlyBlue,
                  value: 1.0,
                  minHeight: 10,
                  color: InduktifTheme.darkText,
                ),
              ),
            ));
            tempList.addAll(value);
            emit(SearchLoaded(searchingModel: tempList));
          } else {
            emit(SearchLoaded(
                searchingModel: fakeList, pesan: const Text('404 Not Found!')));
          }
        } on TimeoutException {
          emit(SearchLoaded(
              searchingModel: fakeList,
              pesan: const Text('Waktu koneksi >200 s')));
        } on SocketException {
          emit(SearchLoaded(
              searchingModel: fakeList,
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
          emit(SearchLoaded(
              searchingModel: fakeList, pesan: const Text('Data invalid.')));
        }
      } else {
        emit(SearchLoaded(
          searchingModel: showFirst,
          pesan: const Padding(
            padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
            child: LinearProgressIndicator(
              backgroundColor: InduktifTheme.nearlyBlue,
              value: 0.2,
              minHeight: 10,
              color: InduktifTheme.darkText,
            ),
          ),
        ));
        try {
          emit(SearchLoaded(
            searchingModel: showFirst,
            pesan: const Padding(
              padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
              child: LinearProgressIndicator(
                backgroundColor: InduktifTheme.nearlyBlue,
                value: 0.3,
                minHeight: 10,
                color: InduktifTheme.darkText,
              ),
            ),
          ));
          http.Response response =
              await http.get(loginTI).timeout(Duration(seconds: timeout));
          if (response.statusCode == 200) {
            emit(SearchLoaded(
              searchingModel: showFirst,
              pesan: const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: LinearProgressIndicator(
                  backgroundColor: InduktifTheme.nearlyBlue,
                  value: 0.4,
                  minHeight: 10,
                  color: InduktifTheme.darkText,
                ),
              ),
            ));
            Response? link = await searchingNetwork.loginToUrl();
            emit(SearchLoaded(
              searchingModel: showFirst,
              pesan: const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: LinearProgressIndicator(
                  backgroundColor: InduktifTheme.nearlyBlue,
                  value: 0.6,
                  minHeight: 10,
                  color: InduktifTheme.darkText,
                ),
              ),
            ));
            String? linkToken = await searchingNetwork.getLinkToken(link);
            emit(SearchLoaded(
              searchingModel: showFirst,
              pesan: const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: LinearProgressIndicator(
                  backgroundColor: InduktifTheme.nearlyBlue,
                  value: 0.9,
                  minHeight: 10,
                  color: InduktifTheme.darkText,
                ),
              ),
            ));
            var value = await searchingNetwork.getSearchResult(linkToken);
            emit(SearchLoaded(
              searchingModel: showFirst,
              pesan: const Padding(
                padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                child: LinearProgressIndicator(
                  backgroundColor: InduktifTheme.nearlyBlue,
                  value: 1.0,
                  minHeight: 10,
                  color: InduktifTheme.darkText,
                ),
              ),
            ));
            tempList.addAll(value);
            emit(SearchLoaded(searchingModel: tempList));
          } else {
            emit(SearchLoaded(
                searchingModel: fakeList, pesan: const Text('404 Not Found!')));
          }
        } on TimeoutException {
          emit(SearchLoaded(
              searchingModel: fakeList,
              pesan: const Text('Waktu koneksi >200 s')));
        } on SocketException {
          emit(SearchLoaded(
              searchingModel: fakeList,
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
          emit(SearchLoaded(
              searchingModel: fakeList, pesan: const Text('Data invalid.')));
        }
      }
    });
  }
}
