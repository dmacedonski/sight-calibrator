import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sight_calibrator/data/app_database.dart';
import 'package:sight_calibrator/main_activity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db =
      await $FloorAppDatabase.databaseBuilder('sight_calibrator.db').build();
  final cameras = await availableCameras();
  final camera = cameras.firstWhere(
      (element) => element.lensDirection == CameraLensDirection.back);
  runApp(MyApp(db: db, camera: camera));
}

class MyApp extends StatelessWidget {
  final AppDatabase db;
  final CameraDescription camera;

  const MyApp({super.key, required this.db, required this.camera});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sight Calibrator',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: MainActivity(db: db, camera: camera),
    );
  }
}
