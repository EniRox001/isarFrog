// ignore_for_file: avoid_dynamic_calls

import 'package:dart_frog/dart_frog.dart';
import 'package:test_project/models/user.dart';

Future<Response> onRequest(RequestContext context) async {
  // Access the incoming request.
  final request = context.request;

  // Access the query parameters as a `Map<String, String>`.
  final params = request.uri.queryParameters;
  final body = await request.json();

  // Get the value for the key `name`.
  // Default to `there` if there is no query parameter.
  final id = params['id'];

  final user = await isar.users.get(int.parse(id!));

  final email = body['email'] ?? '';
  final age = body['age'];

  if (age != user?.age && age != null) {
    await isar.writeTxn(
      () async {
        user?.email = user.email;
        user?.age = int.parse(age.toString());
        await isar.users.put(
          user!,
        );
      },
    );
  } else if (email != user?.email && email != '') {
    await isar.writeTxn(
      () async {
        user?.email = email.toString();
        user?.age = user.age;
        await isar.users.put(
          user!,
        );
      },
    );
  }

  return Response.json(
    body: {
      'message': 'user updated successfully',
      'user': {
        'id': user?.id,
        'email': user?.email,
        'age': user?.age,
      }
    },
  );
}
