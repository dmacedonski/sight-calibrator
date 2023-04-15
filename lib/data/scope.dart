import 'package:floor/floor.dart';

@entity
class Scope {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String name;
  final double inchesPerClick;
  final double forDistance;

  Scope(this.id, this.name, this.inchesPerClick, this.forDistance);

  factory Scope.create(
          String name, double inchesPerClick, double forDistance) =>
      Scope(null, name, inchesPerClick, forDistance);
}

@dao
abstract class ScopeDao {
  @Query('SELECT * FROM Scope')
  Stream<List<Scope>> findAll();

  @insert
  Future<void> insertOne(Scope scope);

  @delete
  Future<void> deleteOne(Scope scope);
}
