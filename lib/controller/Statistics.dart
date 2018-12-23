
import 'package:group_feed/group_feed.dart';

class Statistics extends ResourceController {

  //TODO implement statistics

  @Operation.get()
  Future<Response> getStats() async {
    return Response.ok({"status" : "Stats coming soon!"});
  }

}