
import 'package:aqueduct/aqueduct.dart';

class FeedProfile extends ResourceController {

  @Operation.get()
  Future<Response> getDefaultFeed() async {
    final defaultEntries = {}; //TODO (grab default entries)
    return Response.ok(defaultEntries);
  }

  @Operation.get('id')
  Future<Response> getFeedById(@Bind.path('id') String feedCode) async {
    final feedCodeEntries = {}; //TODO (grab entries by code)
    return Response.ok(feedCodeEntries);
  }
}