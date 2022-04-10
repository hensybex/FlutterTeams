import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth/login_screen.dart';
import 'package:black_pearl/models/user_model.dart';

import 'package:black_pearl/sevices/sidebar.dart';
import 'package:intl/intl.dart';

class Player extends StatefulWidget {
  String id;
  Player({required this.id});
  @override
  _PlayerState createState() => _PlayerState(id: id);
}

class _PlayerState extends State<Player> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('games')
      .where('Game Date', isGreaterThan: DateTime.now())
      //.where('Opponent', isEqualTo: 'Lizok')
      .snapshots();
  List<DocumentSnapshot> gamesList = [];
  String id;
  var rooll;
  var emaill;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;

  _PlayerState({required this.id});
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(id)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      setState(() {
        emaill = loggedInUser.email.toString();
        rooll = loggedInUser.wrole.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello, $emaill",
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: SideBarWidget(),
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }
          gamesList = snapshot.data!.docs;
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: gamesList.length,
              itemBuilder: (_, index) {
                return Card(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: ListTile(
                          leading: Icon(Icons.album),
                          title: Text(
                            snapshot.data!.docChanges[index].doc['Opponent'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data!.docChanges[index].doc['Opponent'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              DateFormat.yMMMd()
                                  .add_jm()
                                  .format(snapshot
                                      .data!.docChanges[index].doc['Game Date']
                                      .toDate())
                                  .toString(),
                              /*snapshot.data!.docChanges[index]
                                        .doc['Game Date']
                                        .toDate()
                                        .toString(),*/
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text('I will attend the game!'),
                              onPressed: () {
                                subscribeToEvent(
                                  snapshot.data!.docChanges[index].doc['id'],
                                  this.id,
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  /*Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            snapshot.data!.docChanges[index].doc['Opponent'],
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),*/
                );
              },
            ),
          );
        },
      ),
    );
  }

  void subscribeToEvent(String gameId, String playerId) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.uid = user!.uid;

    List list = [];

    list.add(gameId);
    var info = Map<String, Object?>();
    info['subscripted'] = FieldValue.arrayUnion(list);
    await firebaseFirestore.collection("users").doc(user.uid).update(info);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('You are subscribed to event!'),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    LinearProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }
}
