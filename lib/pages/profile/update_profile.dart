import 'package:black_pearl/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:black_pearl/models/user_model.dart';
import 'package:black_pearl/pages/home/home_screen.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() {
    return _UpdateProfileState();
  }
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController playerNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'),
        leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Profile())),
        ),
      ),
      body: Form(
        key: _formkey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: playerNumberController,
                  decoration: InputDecoration(
                    labelText: "Player number",
                    enabled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "First name cannot be empty";
                    }
                    if (!isNumeric(value) || int.parse(value) > 99) {
                      return ("Please enter valid player number");
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  update(int.parse(playerNumberController.text));
                },
                child: Text('Update info'),
              ),
            ]),
      ),
    );
  }

  void update(int playerNumber) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await {postDetailsToFirestore(playerNumber)};
    }
  }

  postDetailsToFirestore(int playerNumber) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.playerNumber = playerNumber;
    userModel.uid = user!.uid;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .update({'playerNumber': playerNumber});

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Profile()));
  }
}
