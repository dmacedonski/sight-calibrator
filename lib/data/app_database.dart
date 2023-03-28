import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sight_calibrator/data/scope.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [Scope])
abstract class AppDatabase extends FloorDatabase {
  ScopeDao get scopeDao;
}
