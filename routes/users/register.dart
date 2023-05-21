// ignore_for_file: avoid_dynamic_calls

import 'package:dart_frog/dart_frog.dart';
import 'package:test_project/models/user.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  final body = await request.json();

  final email = body['email'].toString();
  final password = body['password'].toString();
  final age = int.parse(body['age'].toString());

  try {
    final user = User()
      ..email = email
      ..password = password
      ..age = age;

    await isar.writeTxn(() async {
      await isar.users.put(user);
    });
    return Response.json(
      body: <String, dynamic>{
        'message': 'User created successfully',
        'user': {
          'id': user.id,
          'email': user.email,
          'age': user.age,
        },
      },
    );
  } catch (e) {
    Response.json(
      body: <String, dynamic>{
        'message': 'An error occured',
        'error': e,
      },
    );
  }
  return Response(
    body: 'All attempts failed through',
  );
}
