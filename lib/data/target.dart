import 'package:floor/floor.dart';

@entity
class Target {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final double size;

  Target(this.id, this.name, this.size);

  factory Target.create(String name, double size) => Target(null, name, size);
}

@dao
abstract class TargetDao {
  @Query('SELECT * FROM Target')
  Stream<List<Target>> findAll();

  @insert
  Future<void> insertOne(Target target);

  @delete
  Future<void> deleteOne(Target target);
}
