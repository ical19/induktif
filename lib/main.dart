import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:induktif/domain/model/technical_model.dart';
import 'package:induktif/domain/model/tm_saved_detail.dart';
import 'package:induktif/view/primer/myapp.dart';
// import 'package:induktif/view/seconder/post/notification/notification_service.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  //launcher icon by manshagraphic on flaticon
  WidgetsFlutterBinding.ensureInitialized();
  var appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);
  Hive.registerAdapter(TechnicalModelAdapter());
  Hive.registerAdapter(TMSavedDetailAdapter());
  // await NotificationService.initializeNotification();
  await Hive.openBox('info_teknis_detail');
  runApp(const MyApp());
}
