import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sight_calibrator/data/scope.dart';
import 'package:sight_calibrator/data/target.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Scope, Target])
abstract class AppDatabase extends FloorDatabase {
  ScopeDao get scopeDao;

  TargetDao get targetDao;
}
