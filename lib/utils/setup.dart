import 'package:isar/isar.dart';
import 'package:management/entities/user.dart';
import 'package:path_provider/path_provider.dart';

Future<Isar> setupDB() async {
  final dir = await getApplicationDocumentsDirectory();
  return await Isar.open(
    [UserSchema],
    directory: dir.path,
  );
}
