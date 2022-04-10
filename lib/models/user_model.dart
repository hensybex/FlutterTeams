import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? wrole;
  String? firstName;
  String? secondName;
  DateTime? birthDate;
  int? playerNumber;
  int? height;
  int? weight;
  String? uid;
  int? gamesPlayed = 0;
  int? goalsScored = 0;
  int? assists = 0;
  bool? onBench = true;

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : firstName = (snapshot.data() as Map)['firstName'],
        secondName = (snapshot.data() as Map)['secondName'],
        uid = (snapshot.data() as Map)['uid'];

// receiving data
  UserModel({
    this.uid,
    this.firstName,
    this.secondName,
    this.email,
    this.wrole,
    this.playerNumber,
    this.height,
    this.weight,
    this.birthDate,
    this.onBench,
  });
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      wrole: map['wrool'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      playerNumber: map['playerNumber'],
      height: map['height'],
      weight: map['weight'],
      //birthDate: map['birthDate']);
      birthDate: (map['birthDate'] as Timestamp?)?.toDate(),
      onBench: map['onBench'],
    );
  }
// sending data
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'wrole': wrole,
      'firstName': firstName,
      'secondName': secondName,
      'playerNumber': playerNumber,
      'height': height,
      'weight': weight,
      'assists': assists,
      'goalsScored': goalsScored,
      'gamesPlayed': gamesPlayed,
      'birthDate': birthDate,
      'onBench': onBench,
    };
  }
}
