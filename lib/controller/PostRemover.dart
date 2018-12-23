
import 'package:group_feed/group_feed.dart';

class PostRemover extends Controller {

  PostRemover(this.database);

  Db database;

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final feedCode = request.body.as()['code'];
    final postID = request.body.as()['id'];
    final password = request.body.as()['password'];

    final groups = database.collection('groups');
    final feed = await groups.findOne(where.eq("code", feedCode).eq("password", password));

    if(feed == null) {
      return Response.unauthorized(body: {"error" : "The specified code and/or password is incorrect"});
    }

    final List<dynamic> posts = feed['posts'] as List<dynamic>;

    if(posts != null) {
      posts.removeWhere((post) => post['id'] == postID);
    }

    return Response.ok({"status" : "Successfully removed post"});
  }

}