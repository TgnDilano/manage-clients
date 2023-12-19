import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;

  final String fname;
  final String lname;
  final String phoneNumber;
  final String pcName;
  final String pcSN;
  final String uuid;

  User({
    required this.fname,
    required this.lname,
    required this.phoneNumber,
    required this.pcName,
    required this.pcSN,
    required this.uuid,
  });
}
