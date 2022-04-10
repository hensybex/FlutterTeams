import 'package:cloud_firestore/cloud_firestore.dart';

Future<List> GamesCollector() async {
  List<DateTime> dates = [];
  var data = await FirebaseFirestore.instance
      .collection('games')
      .orderBy('Game Date')
      .get();
  return data.docs;
}
