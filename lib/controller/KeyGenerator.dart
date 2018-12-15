import 'dart:async';
import 'dart:math';

import 'package:aqueduct/aqueduct.dart';

class KeyGenerator extends Controller {

  KeyGenerator(this._codeLength);

  final int _codeLength;

  @override
  FutureOr<RequestOrResponse> handle(Request request) {
    // TODO: implement handle
    return Response.ok({"code" : _randomCode(_codeLength)});
  }

  String _randomCode(int length) {
    var randomGen = Random();
    var codeUnits = List.generate(
        length,
            (index) {
          final numberEntity = randomGen.nextInt(10) + 48;
          final upperLetterEntity = randomGen.nextInt(26) + 65;
          final lowerLetterEntity = randomGen.nextInt(26) + 97;

          final entityChoice = randomGen.nextInt(3);
          return entityChoice > 0 ? entityChoice > 1 ? upperLetterEntity : lowerLetterEntity : numberEntity;
        }
    );

    return String.fromCharCodes(codeUnits);
  }


}