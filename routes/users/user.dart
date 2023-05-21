import 'package:dart_frog/dart_frog.dart';
import 'package:isar/isar.dart';
import 'package:test_project/models/user.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  final params = request.uri.queryParameters;

  final email = params['email'] ?? '';
  final id = params['id'].toString();

  if (email.length < 2) {
    try {
      final user = await isar.users.get(int.parse(id));
      return Response.json(
        body: <String, dynamic>{
          'message': 'user found successfully',
          'user': {
            'id': user?.id,
            'email': user?.email,
            'age': user?.age,
          }
        },
      );
    } catch (e) {
      return Response.json(
        body: <String, dynamic>{'message': 'user does not exist', 'error': e},
      );
    }
  } else if (email.length > 2) {
    try {
      final user = await isar.users.filter().emailEqualTo(email).findAll();

      final selectedUser = user[0];

      return Response.json(
        body: <String, dynamic>{
          'message': 'user found successfully',
          'user': {
            'id': selectedUser.id,
            'email': selectedUser.email,
            'age': selectedUser.age,
          }
        },
      );
    } catch (e) {
      return Response.json(
        body: <String, dynamic>{'message': 'user does not exist', 'error': e},
      );
    }
  } else {
    return Response(body: '');
  }
}
