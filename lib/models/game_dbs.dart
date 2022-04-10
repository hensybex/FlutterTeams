import 'package:black_pearl/models/game_model.dart';

import 'package:firebase_helpers/firebase_helpers.dart';

class AppDBConstants {
  static const String usersCollection = "users";
  static const String gamesCollection = "games";
  //static const String usersStorageBucket = "users";
  //static const String eventsCollection = "events";
  //static const String devicesSubCollection = "devices";
}

final gameDBS = DatabaseService<Game>(
  AppDBConstants.gamesCollection,
  fromDS: (id, data) => Game.fromDS(id, data!),
  toMap: (game) => game.toMap(),
);
