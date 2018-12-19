import 'package:group_feed/controller/KeyGenerator.dart';
import 'package:group_feed/controller/APIKeyValidator.dart';
import 'package:group_feed/controller/FeedProfile.dart';
import 'package:group_feed/controller/GroupInitializer.dart';

import 'group_feed.dart';

const int _codeLength  = 9;

class GroupFeedChannel extends ApplicationChannel {
  ManagedContext context;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    final dataModel = ManagedDataModel.fromCurrentMirrorSystem();
    final persistentStore = PostgreSQLPersistentStore.fromConnectionInfo(
        "admin", "password", "localhost", 5432, "groups");

    context = ManagedContext(dataModel, persistentStore);
  }


  @override
  Controller get entryPoint {
    final router = Router();

    router
      .route("/api/gen")
      .link(() => APIKeyValidator())
      .link(() => KeyGenerator(_codeLength));

    router
      .route("/api/createGroup")
      .link(() => APIKeyValidator())
      .link(() => GroupInitializer(context));
    
    router
        .route("/[:id]")
        .link(() => FeedProfile());

    return router;
  }
}