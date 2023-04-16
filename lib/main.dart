import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sight_calibrator/data/app_database.dart';
import 'package:sight_calibrator/main_activity.dart';

import 'app_settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db =
      await $FloorAppDatabase.databaseBuilder('sight_calibrator.db').build();
  final cameras = await availableCameras();
  final camera = cameras.firstWhere(
      (element) => element.lensDirection == CameraLensDirection.back);
  final AppSettings appSettings = AppSettings.getInstance();
  appSettings.load();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  runApp(MyApp(db: db, camera: camera, packageInfo: packageInfo));
}

class MyApp extends StatelessWidget {
  final AppDatabase db;
  final CameraDescription camera;
  final PackageInfo packageInfo;

  const MyApp(
      {super.key,
      required this.db,
      required this.camera,
      required this.packageInfo});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: AppSettings.getInstance(),
        builder: (context, appSettings, widget) {
          return MaterialApp(
            title: 'Sight Calibrator',
            theme:
                ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
            darkTheme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: Colors.indigo,
                brightness: Brightness.dark),
            themeMode: appSettings.themeMode,
            home:
                MainActivity(db: db, camera: camera, packageInfo: packageInfo),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: appSettings.locale,
          );
        });
  }
}
