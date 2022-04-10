import 'package:black_pearl/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PlayerDetails extends StatelessWidget {
  final UserModel user;

  PlayerDetails({Key? key, required this.user}) : super(key: key);
  CollectionReference usersTable =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user.firstName.toString() + ' ' + user.secondName.toString()),
      //subtitle: Text(DateFormat("EEEE, dd MMMM, yyyy").format(user.birthDate)),
      subtitle: Text(user.email!),
      onTap: () => showDialog(
          context: context,
          builder: (contexxt) => Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                body: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: <Widget>[
                    Text("Idk what was here"),
                    ListTile(
                        leading: Icon(Icons.event),
                        title: Text(
                          user.firstName.toString() +
                              ' ' +
                              user.secondName.toString(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        //subtitle: Text(DateFormat("EEEE, dd MMMM, yyyy")
                        //    .format(user.birthDate)),
                        subtitle: Text(user.email!)),
                    const SizedBox(height: 10.0),
                    const SizedBox(height: 20.0),
                  ],
                ),
              )),
    );
  }
}
