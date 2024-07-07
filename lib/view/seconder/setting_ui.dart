import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:induktif/data/theme/induktif_theme.dart';
import 'package:input_slider/input_slider.dart';
import 'package:settings_ui/settings_ui.dart';

class Pengaturan extends StatelessWidget {
  const Pengaturan({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<dynamic>('pengaturan'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.error != null) {
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong :/'),
              ),
            );
          } else {
            return const MainSetting();
          }
        } else {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const <Widget>[
                Text('Loading...'),
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}

class MainSetting extends StatefulWidget {
  const MainSetting({super.key});
  @override
  State<MainSetting> createState() => _MainSettingState();
}

class _MainSettingState extends State<MainSetting> {
  TextEditingController userTiController = TextEditingController();
  TextEditingController passTiController = TextEditingController();
  Box<dynamic>? pengaturan;

  @override
  void initState() {
    super.initState();
    pengaturan = Hive.box<dynamic>('pengaturan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Setting',
          style: TextStyle(color: InduktifTheme.nearlyBlack),
        ),
        leading: const BackButton(color: InduktifTheme.nearlyBlack),
        backgroundColor: InduktifTheme.nearlyWhite,
      ),
      body: ValueListenableBuilder<Box<dynamic>>(
          valueListenable: pengaturan!.listenable(),
          builder: (context, box, _) {
            return SettingsList(
              sections: [
                SettingsSection(
                  title: const Text('Autentikasi',
                      style: TextStyle(color: InduktifTheme.lightText)),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      leading: const Icon(
                        Icons.key_rounded,
                        color: InduktifTheme.lightText,
                      ),
                      onPressed: (ctx) {
                        showDialog(
                            context: ctx,
                            builder: (context) {
                              bool visibility = false;
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return AlertDialog(
                                  content: Stack(
                                    clipBehavior: Clip.none,
                                    children: <Widget>[
                                      Form(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                controller: userTiController
                                                  ..text = box.get('userTi',
                                                      defaultValue:
                                                          'imam.mustofa@tfirst.co.id'),
                                                decoration: InputDecoration(
                                                    labelText: 'username',
                                                    hintText:
                                                        'username T-First',
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey
                                                            .withOpacity(0.5)),
                                                    prefixIcon: const Icon(
                                                        Icons.person)),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                  controller: passTiController
                                                    ..text = box.get('passTi',
                                                        defaultValue:
                                                            'TDMS1234'),
                                                  obscureText: !visibility,
                                                  enableSuggestions: false,
                                                  autocorrect: false,
                                                  decoration: InputDecoration(
                                                      labelText: 'password',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.5)),
                                                      suffix: IconButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              visibility =
                                                                  !visibility;
                                                            });
                                                          },
                                                          icon: Icon(visibility
                                                              ? Icons
                                                                  .visibility_off
                                                              : Icons
                                                                  .visibility)),
                                                      hintText:
                                                          'password T-First',
                                                      prefixIcon: const Icon(
                                                          Icons.key))),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .greenAccent)),
                                                    child: const Text("Simpan"),
                                                    onPressed: () {
                                                      pengaturan!.put(
                                                          'userTi',
                                                          userTiController
                                                              .text);
                                                      pengaturan!.put(
                                                          'passTi',
                                                          passTiController
                                                              .text);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .redAccent)),
                                                    child: const Text("Batal"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            });
                      },
                      title: const Text('Autentikasi Tfirst'),
                      value: Text(box.get('userTi',
                          defaultValue: 'imam.mustofa@tfirst.co.id')),
                    ),
                    SettingsTile.navigation(
                      enabled: false,
                      onPressed: (ctx) {},
                      leading: const Icon(Icons.key_rounded),
                      title: const Text('Autentikasi EPC'),
                      value: const Text('Suryadi PC'),
                    ),
                  ],
                ),
                SettingsSection(
                  title: const Text('User interface',
                      style: TextStyle(color: InduktifTheme.lightText)),
                  tiles: <SettingsTile>[
                    SettingsTile.switchTile(
                      activeSwitchColor: InduktifTheme.nearlyBlue,
                      onToggle: (value) {
                        setState(() {
                          pengaturan!.put('dynamicColor', value);
                        });
                      },
                      description: const Text('khusus Android 12+ (API 33)'),
                      initialValue:
                          box.get('dynamicColor', defaultValue: false),
                      leading: const Icon(Icons.format_paint),
                      title: const Text('Gunakan warna dinamis'),
                    ),
                    SettingsTile.navigation(
                      onPressed: (ctx) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: InputSlider(
                                onChange: (value) => print("change: $value"),
                                min: 0.0,
                                max: 100.0,
                                decimalPlaces: 0,
                                defaultValue: 50,
                                leading: Text("Percentage:"),
                              ),
                            );
                          },
                        );
                      },
                      title: const Text('Kecepatan animasi'),
                      trailing: const Text('50%'),
                      leading: const Icon(Icons.horizontal_rule_rounded),
                    )
                  ],
                ),
                SettingsSection(
                  title: const Text('Application',
                      style: TextStyle(color: InduktifTheme.lightText)),
                  tiles: <SettingsTile>[
                    SettingsTile.navigation(
                      onPressed: (ctx) {
                        setState(() {});
                      },
                      leading: const Icon(Icons.info_outline),
                      title: const Text('About'),
                      value: const Text('powered by Magenta project'),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
