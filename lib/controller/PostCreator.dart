
import 'dart:math';

import 'package:group_feed/group_feed.dart';

class PostCreator extends Controller {

  PostCreator(this.database);

  Db database;

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final code = request.body.as()['code'];
    final postContent = request.body.as()['content'];
    final groups = database.collection('groups');
    final feed = await groups.findOne(where.eq("code", code));
    var posts = feed['posts'];
    posts ??= [];
    posts.add({"id" : _generatePostId(), "date" : DateTime.now(), "content" : postContent});
    feed['posts'] = posts;
    await groups.save(feed);
    return Response.ok({"status" : "Post successfully created!"});
  }

  int _generatePostId() {
    return Random().nextInt(10000000);
  }

}