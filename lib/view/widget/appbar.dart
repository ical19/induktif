import 'package:flutter/material.dart';
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:induktif/data/theme/material_theme.dart';
import 'package:induktif/view/seconder/myapp/search_view.dart';
import 'package:animations/animations.dart';
import 'package:induktif/view/seconder/setting_ui.dart';
import 'package:induktif/view/widget/testwarna.dart';

Widget getAppBarUI(
    {Color? warnaJudul,
    Color? warnaSimbol,
    BuildContext? context,
    ContainerTransitionType? transitionType}) {
  return OpenContainer(
    transitionDuration: const Duration(milliseconds: 400),
    transitionType: transitionType!,
    openBuilder: (BuildContext context, VoidCallback _) {
      return const SearchView();
    },
    closedBuilder: (BuildContext context, VoidCallback openContainer) {
      return Container(
        color: MaterialTheme.poloBlue,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 18, right: 18),
          child: Row(
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'YaTFa',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'WorkSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            letterSpacing: 0.27,
                            color: warnaJudul ?? InduktifTheme.darkerText,
                          ),
                        ),
                        Text(
                          'Yet another TFirst application',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            letterSpacing: 0.2,
                            color: warnaJudul ?? InduktifTheme.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: 30,
                  height: 60,
                  child: Icon(
                    Icons.search_rounded,
                    size: 30,
                    color: warnaSimbol ?? InduktifTheme.dark_grey,
                  )),
              PopupMenuButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                iconSize: 30,
                onSelected: (value) {
                  switch (value) {
                    case 0:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Pengaturan(),
                          ));
                      break;
                    case 1:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TestWarna(),
                          ));
                      break;
                    default:
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                      value: 0,
                      child: Text('Pengaturan',
                          style: TextStyle(
                              fontSize: 12, color: InduktifTheme.nearlyBlack))),
                  const PopupMenuItem<int>(
                      value: 1,
                      child: Text(
                        'Tentang apps',
                        style: TextStyle(
                            fontSize: 12, color: InduktifTheme.nearlyBlack),
                      )),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
