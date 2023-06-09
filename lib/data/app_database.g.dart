// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ScopeDao? _scopeDaoInstance;

  TargetDao? _targetDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Scope` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `inchesPerClick` REAL NOT NULL, `forDistance` REAL NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Target` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `size` REAL NOT NULL, `distance` REAL NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ScopeDao get scopeDao {
    return _scopeDaoInstance ??= _$ScopeDao(database, changeListener);
  }

  @override
  TargetDao get targetDao {
    return _targetDaoInstance ??= _$TargetDao(database, changeListener);
  }
}

class _$ScopeDao extends ScopeDao {
  _$ScopeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _scopeInsertionAdapter = InsertionAdapter(
            database,
            'Scope',
            (Scope item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'inchesPerClick': item.inchesPerClick,
                  'forDistance': item.forDistance
                },
            changeListener),
        _scopeDeletionAdapter = DeletionAdapter(
            database,
            'Scope',
            ['id'],
            (Scope item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'inchesPerClick': item.inchesPerClick,
                  'forDistance': item.forDistance
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Scope> _scopeInsertionAdapter;

  final DeletionAdapter<Scope> _scopeDeletionAdapter;

  @override
  Stream<List<Scope>> findAll() {
    return _queryAdapter.queryListStream('SELECT * FROM Scope',
        mapper: (Map<String, Object?> row) => Scope(
            row['id'] as int?,
            row['name'] as String,
            row['inchesPerClick'] as double,
            row['forDistance'] as double),
        queryableName: 'Scope',
        isView: false);
  }

  @override
  Future<void> insertOne(Scope scope) async {
    await _scopeInsertionAdapter.insert(scope, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOne(Scope scope) async {
    await _scopeDeletionAdapter.delete(scope);
  }
}

class _$TargetDao extends TargetDao {
  _$TargetDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _targetInsertionAdapter = InsertionAdapter(
            database,
            'Target',
            (Target item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'size': item.size,
                  'distance': item.distance
                },
            changeListener),
        _targetDeletionAdapter = DeletionAdapter(
            database,
            'Target',
            ['id'],
            (Target item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'size': item.size,
                  'distance': item.distance
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Target> _targetInsertionAdapter;

  final DeletionAdapter<Target> _targetDeletionAdapter;

  @override
  Stream<List<Target>> findAll() {
    return _queryAdapter.queryListStream('SELECT * FROM Target',
        mapper: (Map<String, Object?> row) => Target(
            row['id'] as int?,
            row['name'] as String,
            row['size'] as double,
            row['distance'] as double),
        queryableName: 'Target',
        isView: false);
  }

  @override
  Future<void> insertOne(Target target) async {
    await _targetInsertionAdapter.insert(target, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteOne(Target target) async {
    await _targetDeletionAdapter.delete(target);
  }
}
