import 'package:floor/floor.dart';

@entity
class Target {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final double size;
  final double distance;

  Target(this.id, this.name, this.size, this.distance);

  factory Target.create(String name, double size, double distance) =>
      Target(null, name, size, distance);
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
