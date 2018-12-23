
import 'package:group_feed/group_feed.dart';

class FeedProfile extends ResourceController {

  FeedProfile(this.database);

  final Db database;

  @Operation.get('id')
  Future<Response> getFeedById(@Bind.path('id') String feedCode) async {
    final feedCodeEntries = await database.collection("groups").findOne(where.eq("code", feedCode));
    if(feedCodeEntries == null) {
      return Response.notFound(body: {"error" : "Could not find the specified feed"});
    }
    return Response.ok(feedCodeEntries['posts']);
  }

}