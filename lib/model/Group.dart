import 'package:aqueduct/aqueduct.dart';

class Group extends ManagedObject<_Group> implements _Group {

}

class _Group {
  @primaryKey
  String code;

  @Column()
  String password;

  //returns posts ids, which can be used to query the actual posts
  @Column()
  List<String> posts;
}