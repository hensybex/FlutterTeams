import 'package:cloud_firestore/cloud_firestore.dart';

import './user_model.dart';
import 'package:flutter/material.dart';
import 'package:black_pearl/models/user_model.dart';

class GoalScored {
  int? minute;
  UserModel? scorer;
  UserModel? assister;
  String? type;
}

class GoalMissed {
  int? minute;
  String? type;
}

class Substisute {
  int? minute;
  UserModel? left;
  UserModel? entered;
}

class RedCard {
  int? minute;
  UserModel? recieved;
}

class YellowCard {
  int? minute;
  UserModel? recieved;
}

class Injure {
  int? minute;
  UserModel? recieved;
}

class Game {
  String? id;
  String? place;
  bool? isHome;
  late String opponentName;
  DateTime gameDate;
  TimeOfDay? gameTime;
  List<UserModel>? startingSquad;
  List<UserModel>? subscribedPlayers;
  List<GoalScored>? goalsFor;
  List<GoalMissed>? goalsAgainst;
  List<Substisute>? substitutes;
  List<RedCard>? redCards;
  List<YellowCard>? yellowCards;
  List<Injure>? injures;
  Game({
    required this.id,
    required this.opponentName,
    required this.gameDate,
    this.isHome,
    this.subscribedPlayers,
  });

  //Game();
  //Game(this.opponentName, this.gameDate, this.isHome);

  Game.fromSnapshot(DocumentSnapshot snapshot)
      : opponentName = (snapshot.data() as Map)['Opponent'],
        gameDate = (snapshot.data() as Map)['Game Date'].toDate(),
        isHome = (snapshot.data() as Map)['Home?'],
        id = (snapshot.data() as Map)['id'];

  Map<String, dynamic> toMap() {
    return {
      'gameDate': gameDate,
      'opponentName': opponentName,
      'documentId': id,
      'isHome': isHome,
    };
  }

  static Game fromDS(String id, Map<String, dynamic> data) {
    //if (data == null) return null;
    //print(data);
    return Game(
        gameDate: data['Game Date'].toDate(),
        opponentName: data['Opponent'],
        id: id,
        isHome: data['Home?']);
  }
}
