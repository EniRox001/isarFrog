import 'package:dart_frog/dart_frog.dart';
import 'package:test_project/models/user.dart';

Handler middleware(Handler handler) {
  return (context) async {
    // Initialize Isar DB
    try {
      await initializeDB();
    } catch (e) {
      // Catch the error here
    }
    // Forward the request to the respective handler.
    final response = await handler(context);

    // Execute code after request is handled.

    // Return a response.
    return response;
  };
}
