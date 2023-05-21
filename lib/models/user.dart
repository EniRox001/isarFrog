// ignore_for_file: public_member_api_docs

import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  String? email;
  String? password;
  int? age;
}

late Isar isar;
late User user;

Future<void> initializeDB() async {
  await Isar.initializeIsarCore(download: true);
  isar = await Isar.open(
    [UserSchema],
    directory: './',
  );
}
