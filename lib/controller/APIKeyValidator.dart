
import 'dart:async';

import 'package:aqueduct/aqueduct.dart';


const String _temporaryApiKey = "scarger2018";

class APIKeyValidator extends Controller {

  @override
  FutureOr<RequestOrResponse> handle(Request request) {
    final String apiKey = request.raw.uri.queryParameters["apiKey"];
    if(apiKey == null) {
      return Response.unauthorized(body: {"error": "Please provide an API Key!"});
    }
    else if(apiKey == _temporaryApiKey) {
      return request;
    }
    else {
      return Response.unauthorized(body: {"error" : "Invalid API Key."});
    }
  }

}