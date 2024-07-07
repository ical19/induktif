// ignore_for_file: unnecessary_const

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:induktif/data/theme/material_theme.dart';
import 'package:induktif/domain/logic/technical_info/list_bloc.dart';
import 'package:induktif/domain/model/technical_model.dart';
import 'package:induktif/view/seconder/myapp/technical_information.dart';
import 'package:induktif/view/widget/appbar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static List<TechnicalModel>? _listTechnicalModel;
  static List<TechnicalModel> _searchTI = List.from(_listTechnicalModel!);

  List<TechnicalModel> get listTechnicalModel => _listTechnicalModel!;
  set listTechnicalModel(List<TechnicalModel> value) {
    _listTechnicalModel = List.from(value);
  }

  List<TechnicalModel> get searchTI => _searchTI;
  set searchTI(List<TechnicalModel> value) {
    _searchTI = List.from(value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TechInfoBloc()..add(TechInfoEvent()),
          ),
        ],
        child: const MyHomePage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            getAppBarUI(
                transitionType: ContainerTransitionType.fadeThrough,
                context: context,
                warnaJudul: InduktifTheme.darkText,
                warnaSimbol: InduktifTheme.darkerText),
            Container(
              height: 25,
              color: MaterialTheme.poloBlue,
              child: TabBar(
                labelColor: InduktifTheme.darkerText, // Warna teks tab aktif
                unselectedLabelColor:
                    InduktifTheme.deactivatedText, // Warna teks tab tidak aktif
                indicator: const BoxDecoration(
                  color: InduktifTheme.nearlyWhite, // Warna indikator kustom
                ),
                controller: DefaultTabController.of(context),
                tabs: const [
                  Tab(text: 'Technical Information'),
                  Tab(text: 'Service Bulletin'),
                  Tab(text: 'Field Action'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  TechnicalInformation(),
                  Center(child: Text('Transit Tab')),
                  Center(child: Text('Bike Tab')),
                ],
              ),
            ),
            // const Expanded(
            //   child: TechnicalInformation(),
            // )
          ],
        ),
      ),
    );
  }
}
