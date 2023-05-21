import 'package:dart_frog/dart_frog.dart';
import 'package:test_project/models/user.dart';

Future<Response> onRequest(RequestContext context) async {
  final request = context.request;

  final params = request.uri.queryParameters;

  final id = params['id'];

  final user = await isar.users.get(int.parse(id!));

  await isar.writeTxn(() async {});

  return Response.json(
    body: <String, dynamic>{
      'message': 'user deleted successfully',
      'user': {
        'id': user?.id,
        'email': user?.email,
        'age': user?.age,
      }
    },
  );
}
