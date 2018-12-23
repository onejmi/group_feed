import 'package:group_feed/controller/KeyGenerator.dart';
import 'package:group_feed/controller/APIKeyValidator.dart';
import 'package:group_feed/controller/FeedProfile.dart';
import 'package:group_feed/controller/GroupInitializer.dart';
import 'package:group_feed/controller/GroupDestroyer.dart';
import 'package:group_feed/controller/Statistics.dart';
import 'package:group_feed/controller/PostCreator.dart';
import 'package:group_feed/controller/PostRemover.dart';

import 'group_feed.dart';


const int _codeLength  = 9;

class GroupFeedChannel extends ApplicationChannel {

  Db database;

  @override
  Future prepare() async {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));

    database = Db("mongodb://localhost:27017/group_feed");
    await database.open();
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
      .link(() => GroupInitializer(database));

    router
      .route("/api/destroyGroup")
      .link(() => APIKeyValidator())
      .link(() => GroupDestroyer(database));

    router
      .route("/api/stats")
      .link(() => APIKeyValidator())
      .link(() => Statistics());

    router
      .route("/api/createPost")
      .link(() => APIKeyValidator())
      .link(() => PostCreator(database));

    router
      .route("/api/removePost")
      .link(() => APIKeyValidator())
      .link(() => PostRemover(database));
    
    router
        .route("/g/:id")
        .link(() => FeedProfile(database));

    return router;
  }
}