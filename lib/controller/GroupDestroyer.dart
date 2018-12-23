
import 'package:group_feed/group_feed.dart';

class GroupDestroyer extends Controller {

  GroupDestroyer(this.database);

  final Db database;

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final code = request.raw.uri.queryParameters['code'];
    final password = request.raw.uri.queryParameters['password'];

    if(code == null) {
      return Response.badRequest(body: {"error" : "Please provide a group code"});
    }

    if(password == null) {
      return Response.badRequest(body : {"error" : "Please provide a group password"});
    }

    final groups = database.collection("groups");
    final response = await groups.remove(where.eq("code", code).eq("password", password));

    if(response['n'] as int < 1) {
      return Response.notFound(body : {"error" : "Could not find the specified group. "
          "Please make sure the provided code and password are correct"});
    }

    return Response.ok({"status" : "Success! The group $code has been removed"});
  }

}
