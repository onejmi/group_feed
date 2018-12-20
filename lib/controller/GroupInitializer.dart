
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aqueduct/aqueduct.dart';
import 'package:uuid/uuid.dart';

import 'package:group_feed/model/Group.dart';

class GroupInitializer extends Controller {

  GroupInitializer(this.context);

  ManagedContext context;

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final code = await _generateCode(request.raw.uri.queryParameters['apiKey']);
    final password = Uuid().v4();
    final query = Query<Group>(context)..values.password = password as String..values.code = code;
    return Response.ok({"code" : code});
  }

  Future<String> _generateCode(String apiKey) async {
    const baseURL = 'http://localhost:8888';
    final request = await HttpClient().getUrl(Uri.parse('$baseURL/api/gen?apiKey=$apiKey'));
    final response = await request.close();// sends the request
    return jsonDecode(await response.transform(const Utf8Decoder()).first)["code"] as String;
  }

}