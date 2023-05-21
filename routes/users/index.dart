// ignore_for_file: omit_local_variable_types, strict_raw_type,
// prefer_final_locals

import 'package:dart_frog/dart_frog.dart';
import 'package:isar/isar.dart';
import 'package:test_project/models/user.dart';

Future<Response> onRequest(RequestContext context) async {
  try {
    final users = await isar.users.where().findAll();
    final List formattedUserList = [];

    for (var i = 0; i < users.length; i++) {
      final Map user = {
        'id': users[i].id,
        'email': users[i].email,
        'age': users[i].age,
      };

      formattedUserList.add(user);
    }
    return Response.json(
      body: <String, List>{
        'users': formattedUserList,
      },
    );
  } catch (e) {
    return Response.json(
      body: {
        'message': 'an error occured',
        'error': e,
      },
    );
  }
}
