
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aqueduct/aqueduct.dart';
import 'package:uuid/uuid.dart';

import 'package:mongo_dart/mongo_dart.dart';


class GroupInitializer extends Controller {

  GroupInitializer(this.database);

  final Db database;

  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final code = await _generateCode(request.raw.uri.queryParameters['apiKey']);
    final password = Uuid().v4();
    final groups = database.collection("groups");
    await groups.insert({"code" : code, "password" : password});
    return Response.ok({"code" : code});
  }

  Future<String> _generateCode(String apiKey) async {
    const baseURL = 'http://localhost:8888';
    final request = await HttpClient().getUrl(Uri.parse('$baseURL/api/gen?apiKey=$apiKey'));
    final response = await request.close();// sends the request
    return jsonDecode(await response.transform(const Utf8Decoder()).first)["code"] as String;
  }

}