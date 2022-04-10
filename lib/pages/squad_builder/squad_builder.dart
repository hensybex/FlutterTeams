import 'package:black_pearl/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:black_pearl/sevices/sidebar.dart';
import 'package:black_pearl/pages/squad_builder/movable_object.dart';
import 'package:flutter/rendering.dart';

class SquadBuilder extends StatefulWidget {
  const SquadBuilder({Key? key}) : super(key: key);

  @override
  _SquadBuilderState createState() => _SquadBuilderState();
}

class _SquadBuilderState extends State<SquadBuilder> {
  final Stream<QuerySnapshot> _playersStream = FirebaseFirestore.instance
      .collection('users')
      .where('wrole', isEqualTo: 'Player')
      .where('onBench', isEqualTo: true)
      .snapshots();
  UserModel emptyPlayer = UserModel(firstName: "Empty", secondName: "Empty");
  List players = [];
  List<DocumentSnapshot> playersList = [];
  Color activeColor = Colors.white;
  static List<bool> activePlayers = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];
  static List<bool> activeTargets = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();

    players.addAll([
      'Лобойко',
      'Савинов',
      'Буров',
      'Воробьев',
      'Халенов',
      'Перинский',
      'Цырентарев',
      'Семчишин',
      'Болотов',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color mainColor = Colors.grey.withOpacity(0.5);

    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Squad Builder'),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
        actions: [
          ElevatedButton(
              onPressed: () {
                print(activeTargets[0].toString());
                print(_SquadBuilderState.activeTargets[0].toString());
              },
              child: const Text('Save Formation')),
        ],
      ),
      drawer: SideBarWidget(),
      body: Column(
        children: [
          Expanded(
            flex: 85,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Football_field.svg.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: null /* add child content here */,
                ),
                Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: PlayerTarget(
                                arrayNum: 0,
                                activeTarget: activeTargets[0],
                                activePlayer: emptyPlayer,
                                activeColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                /* GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 5,
                  children: [
                    Center(
                        child: PlayerTarget(
                      arrayNum: 0,
                      activeTarget: activeTargets[0],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 1,
                      activeTarget: activeTargets[1],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 2,
                      activeTarget: activeTargets[2],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 3,
                      activeTarget: activeTargets[3],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 4,
                      activeTarget: activeTargets[4],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 5,
                      activeTarget: activeTargets[5],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 6,
                      activeTarget: activeTargets[6],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 7,
                      activeTarget: activeTargets[7],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 8,
                      activeTarget: activeTargets[8],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 9,
                      activeTarget: activeTargets[9],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 10,
                      activeTarget: activeTargets[10],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 11,
                      activeTarget: activeTargets[11],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 12,
                      activeTarget: activeTargets[12],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 13,
                      activeTarget: activeTargets[13],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 14,
                      activeTarget: activeTargets[14],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 15,
                      activeTarget: activeTargets[15],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 16,
                      activeTarget: activeTargets[16],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 17,
                      activeTarget: activeTargets[17],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 18,
                      activeTarget: activeTargets[18],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 19,
                      activeTarget: activeTargets[19],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 20,
                      activeTarget: activeTargets[20],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 21,
                      activeTarget: activeTargets[21],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 22,
                      activeTarget: activeTargets[22],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 23,
                      activeTarget: activeTargets[23],
                      activeColor: Colors.white,
                      activePlayer: emptyPlayer,
                    )),
                    Center(
                        child: PlayerTarget(
                      arrayNum: 24,
                      activeTarget: activeTargets[24],
                      activePlayer: emptyPlayer,
                      activeColor: Colors.white,
                    )),
                  ],
                ), */
                /* Center(
                child: DragArea(
                  child: Icon(
                    Icons.circle,
                    color: Colors.indigo,
                  ),
                  xPos1: 307,
                  yPos1: 650,
                  xPos2: 307,
                  yPos2: 550,
                  xPos3: 107,
                  yPos3: 450,
                  xPos4: 507,
                  yPos4: 450,
                  xPos5: 257,
                  yPos5: 380,
                  xPos6: 357,
                  yPos6: 330,
                  xPos7: 127,
                  yPos7: 250,
                  xPos8: 487,
                  yPos8: 250,
                ),
              ), */
              ],
            ),
          ),
          Expanded(
            flex: 15,
            child: StreamBuilder(
              stream: _playersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text("something is wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LinearProgressIndicator();
                }
                playersList = snapshot.data!.docs;
                return Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    itemCount: playersList.length,
                    scrollDirection: Axis.horizontal,
                    //shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return Center(
                        child: PlayerCard(
                          activePlayer:
                              UserModel.fromSnapshot(playersList[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerCard extends StatelessWidget {
  @override
  UserModel activePlayer;

  PlayerCard({
    Key? key,
    required this.activePlayer,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height,
        child: Draggable(
          data: activePlayer,
          child: Card(
            child: Column(
              children: [
                Text(activePlayer.firstName!),
                Text(activePlayer.secondName!),
              ],
            ),
          ),
          feedback: Card(
            child: Column(
              children: [
                Text("Player Photo"),
                Text("Player Name"),
              ],
            ),
          ),
          childWhenDragging: Card(
            child: Column(
              children: [
                Text("Player Photo"),
                Text("Player Name"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlayerTarget extends StatefulWidget {
  bool activeTarget;
  int arrayNum;
  Color activeColor;
  UserModel activePlayer;

  PlayerTarget({
    Key? key,
    required this.arrayNum,
    required this.activeTarget,
    required this.activeColor,
    required this.activePlayer,
  }) : super(key: key);

  @override
  _PlayerTargetState createState() => _PlayerTargetState();
}

class _PlayerTargetState extends State<PlayerTarget> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  var info = Map<String, Object?>();

  @override
  Widget build(BuildContext context) {
    return DragTarget<UserModel>(
      builder: (context, data, rejected) {
        return Container(
          width: 100,
          height: 100,
          color: Colors.blue.withOpacity(0.1),
          child: widget.activeTarget == false
              ? Center(
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.9),
                    ),
                  ),
                )
              : PlayerCard(
                  activePlayer: widget.activePlayer,
                ),
        );
      },
      onLeave: (data) {
        if (widget.activePlayer.uid == data?.uid) {
          setState(
            () {
              widget.activeTarget = false;
              _SquadBuilderState.activeTargets[widget.arrayNum] = false;
              info['onBench'] = true;
              firebaseFirestore
                  .collection("users")
                  .doc(widget.activePlayer.uid)
                  .update(info);
            },
          );
        }
      },
      onAccept: (data) {
        setState(() {
          widget.activeTarget = true;
          widget.activePlayer = data;
          _SquadBuilderState.activePlayers[widget.arrayNum] = true;
          info['onBench'] = false;
          firebaseFirestore
              .collection("users")
              .doc(widget.activePlayer.uid)
              .update(info);
        });
      },
    );
  }
}
