import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:induktif/domain/logic/technical_info/list_bloc.dart';
import 'package:induktif/domain/model/tm_saved_detail.dart';
import 'package:induktif/view/seconder/myapp/technical_information_detail.dart';
import 'package:induktif/view/seconder/post/pi_saved_detail.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class TechnicalInformation extends StatefulWidget {
  const TechnicalInformation({super.key});

  @override
  State<TechnicalInformation> createState() => _TechnicalInformationState();
}

List<bool> selected = List.generate(500, (index) => false);
Box infoTeknisDetail = Hive.box('info_teknis_detail');

class _TechnicalInformationState extends State<TechnicalInformation> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          BlocBuilder<TechInfoBloc, TechInfoState>(builder: (context, state) {
        if (state is TechInfoUninitialized) {
          return Center(
            child: LoadingAnimationWidget.waveDots(
                color: InduktifTheme.darkText, size: 30),
          );
        } else {
          Future<void> pullRefresh() async {
            context.read<TechInfoBloc>().add(TechInfoEvent());
          }

          TechInfoLoaded techInfoLoaded = state as TechInfoLoaded;
          return SizedBox(
            child: (techInfoLoaded.technicalModel![0].judulTI == '0')
                ? Center(
                    child: techInfoLoaded.childApp ?? techInfoLoaded.pesan,
                  )
                : RefreshIndicator(
                    onRefresh: pullRefresh,
                    color: InduktifTheme.nearlyBlack,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: techInfoLoaded.technicalModel!.length,
                      itemBuilder: (context, index) {
                        return OpenContainer(
                            closedShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            transitionDuration:
                                const Duration(milliseconds: 400),
                            transitionType: ContainerTransitionType.fade,
                            openBuilder: ((context, action) {
                              if (infoTeknisDetail.containsKey(techInfoLoaded
                                  .technicalModel![index].idUrl)) {
                                var infoTeknis = infoTeknisDetail.get(
                                    techInfoLoaded.technicalModel![index]
                                        .idUrl) as TMSavedDetail;
                                return PISavedDetail(
                                  tmSavedDetail: infoTeknis,
                                  technicalModel:
                                      techInfoLoaded.technicalModel![index],
                                );
                              } else {
                                return TechnicalInformationDetail(
                                  idUrl: techInfoLoaded
                                      .technicalModel![index].idUrl,
                                  headers: techInfoLoaded
                                      .technicalModel![index].headers,
                                  cookiesWeb: techInfoLoaded
                                      .technicalModel![index].cookiesWeb,
                                );
                              }
                            }),
                            closedBuilder: ((context, action) {
                              return ListTile(
                                onTap: () {
                                  setState(() {
                                    if (selected[index] == true) {
                                      selected[index] = selected[index];
                                    } else {
                                      selected[index] = !selected[index];
                                    }
                                  });
                                  action();
                                },
                                enableFeedback: true,
                                hoverColor: Colors.amberAccent,
                                selectedTileColor:
                                    InduktifTheme.deactivatedText,
                                selected: selected[index],
                                leading: Image(
                                  colorBlendMode: BlendMode.colorBurn,
                                  image: AssetImage((techInfoLoaded
                                          .technicalModel![index].judulTI
                                          .toLowerCase()
                                          .contains(techInfoLoaded
                                              .technicalModel![index].namaMobil
                                              .toLowerCase()))
                                      ? 'assets/images/${techInfoLoaded.technicalModel![index].namaMobil.toLowerCase().split(' ')[0]}.png'
                                      : 'assets/images/rush.png'),
                                ),
                                tileColor: infoTeknisDetail.containsKey(
                                            techInfoLoaded
                                                .technicalModel![index]
                                                .idUrl) &&
                                        selected[index]
                                    ? InduktifTheme.deactivatedText
                                    : null,
                                title: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(children: [
                                    Text(
                                      techInfoLoaded
                                          .technicalModel![index].nomorTI,
                                      style: InduktifTheme.title.copyWith(
                                          color: InduktifTheme.nearlyBlue),
                                    ),
                                    Text(
                                      techInfoLoaded
                                          .technicalModel![index].publishedDate,
                                      style: const TextStyle(
                                          color: Colors.amberAccent,
                                          fontSize: 12),
                                    )
                                  ]),
                                ),
                                subtitle: Text(
                                  '${techInfoLoaded.technicalModel![index].judulTI.capitalize()}..',
                                  style: InduktifTheme.subtitle.copyWith(
                                    fontFamily: "",
                                    color: selected[index]
                                        ? InduktifTheme.notWhite
                                        : InduktifTheme.deactivatedText,
                                  ),
                                ),
                              );
                            }));
                      },
                    ),
                  ),
          );
        }
      }),
    );
  }
}
