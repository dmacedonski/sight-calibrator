import 'package:flutter/material.dart';
import 'package:sight_calibrator/data/app_database.dart';
import 'package:sight_calibrator/main_activity.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db =
      await $FloorAppDatabase.databaseBuilder('sight_calibrator.db').build();
  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final AppDatabase db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sight Calibrator',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: MainActivity(db: db),
    );
  }
}
