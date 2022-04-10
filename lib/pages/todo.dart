import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:black_pearl/sevices/sidebar.dart';

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  State<ToDo> createState() => ToDoState();
}

class ToDoState extends State<ToDo> {
  late String userToDo;
  List todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('ToDo'),
        backgroundColor: Colors.deepOrangeAccent,
        centerTitle: true,
      ),
      drawer: SideBarWidget(),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) return Text('No data');
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    child: Card(
                      child: ListTile(
                          title: Text(snapshot.data!.docs[index].get('item')),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete_sweep,
                              color: Colors.deepOrangeAccent,
                            ),
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('items')
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            },
                          )),
                    ),
                    onDismissed: (direction) {
                      FirebaseFirestore.instance
                          .collection('items')
                          .doc(snapshot.data!.docs[index].id)
                          .delete();
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Add element'),
                    content: TextField(
                      onChanged: (String value) {
                        userToDo = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('items')
                                .add({'item': userToDo});

                            Navigator.of(context).pop();
                          },
                          child: Text('Add'))
                    ],
                  );
                });
          },
          child: Icon(
            Icons.add_box,
            color: Colors.white,
          )),
    );
  }
}
