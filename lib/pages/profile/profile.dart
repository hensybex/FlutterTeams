import 'package:black_pearl/sevices/player_details.dart';
import 'package:black_pearl/pages/profile/update_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:black_pearl/sevices/sidebar.dart';
import 'package:black_pearl/models/user_model.dart';
import 'package:black_pearl/pages/home/home_screen.dart';
import 'package:black_pearl/pages/auth/login_screen.dart';
import 'dart:convert';
import '../home/player.dart';
import '../home/coach.dart';
import 'package:intl/intl.dart';

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  //_HomeScreenState();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  var role;
  var email;
  var id;
  int? playerNumber;
  String? firstName;
  String? secondName;
  int? height;
  int? weight;
  DateTime? birthDate;
  DateTime? dt;
  Timestamp? bDay;
  late String birthDateString;
  FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController playerNumberController = TextEditingController();

  Timestamp _dateTimeToTimestamp(DateTime dateTime) {
    return Timestamp.fromMillisecondsSinceEpoch(
        dateTime.millisecondsSinceEpoch);
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users") //.where('uid', isEqualTo: user!.uid)
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());

      Map<String, dynamic>? map = value.data();
      dt = (map!['birthDate'] as Timestamp).toDate();
    }).whenComplete(() {
      LinearProgressIndicator();
      setState(() {
        email = loggedInUser.email.toString();
        role = loggedInUser.wrole.toString();
        id = loggedInUser.uid.toString();
        height = loggedInUser.height;
        weight = loggedInUser.weight;
        birthDate = loggedInUser.birthDate;
        if (birthDate != null) {
          birthDateString = DateFormat('dd-MM-yyyy').format(birthDate!);
        } else {
          birthDateString = "Null";
        }
        firstName = loggedInUser.firstName;
        secondName = loggedInUser.secondName;
        playerNumber = loggedInUser.playerNumber;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("users") //.where('uid', isEqualTo: user!.uid)
          .doc(user!.uid)
          .get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
            ),
            drawer: SideBarWidget(),
            body: Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Text(
                        "Edit Profile",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10),
                                  )
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('piessa.jpg'),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.green,
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      buildTextField(
                          "First Name", firstName, firstNameController),
                      buildTextField(
                          "Second Name", secondName, secondNameController),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(bottom: 3),
                                  labelText: 'Birth Date',
                                  labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  hintText: birthDateString,
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  enabled: false,
                                ),
                                onChanged: (value) {},
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                birthDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2023),
                                );
                                birthDateString =
                                    DateFormat('dd-MM-yyyy').format(birthDate!);
                                setState(() {
                                  birthDateString = DateFormat('dd-MM-yyyy')
                                      .format(birthDate!);
                                });
                              },
                              child: Text('Select birth date'),
                            ),
                          ),
                        ],
                      ),
                      buildPNumTextField("Player Number",
                          playerNumber.toString(), playerNumberController),
                      buildIntTextField(
                          "Height", height.toString(), heightController),
                      buildIntTextField(
                          "Weight", weight.toString(), weightController),
                      SizedBox(
                        height: 35,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          update(
                            firstNameController.text,
                            secondNameController.text,
                            playerNumberController.text,
                            heightController.text,
                            weightController.text,
                            birthDate!,
                          );
                        },
                        child: Text('Confirm Changes'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          /*return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Profile",
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
              body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField('Text'),
                        TextField('Text'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextField(),
                        TextField(),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateProfile()));
                      },
                      child: Text(
                        "Update profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ])));*/
        }
        return LinearProgressIndicator();
      },
    );
  }

  Widget buildTextField(
      String labelText, String? placeHolder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          enabled: true,
        ),
        validator: (value) {
          if (!value!.isEmpty) {
            if (!RegExp("^[a-zA-Z]").hasMatch(value)) {
              return ("Please enter valid " + labelText.toLowerCase());
            } else {
              return null;
            }
          }
        },
        onChanged: (value) {},
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget buildPNumTextField(
      String labelText, String? placeHolder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          enabled: true,
        ),
        validator: (value) {
          if (!value!.isEmpty) {
            if (!isNumeric(value) || int.parse(value) > 99) {
              return ("Please enter valid " + labelText.toLowerCase());
            } else {
              return null;
            }
          }
        },
        onChanged: (value) {},
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget buildIntTextField(
      String labelText, String? placeHolder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.black,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          enabled: true,
        ),
        validator: (value) {
          if (!value!.isEmpty) {
            if (!isNumeric(value)) {
              return ("Please enter valid " + labelText.toLowerCase());
            } else {
              return null;
            }
          }
        },
        onChanged: (value) {},
        keyboardType: TextInputType.number,
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

  void update(String firstName, String secondName, String playerNumber,
      String height, String weight, DateTime birthDate) async {
    LinearProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await {
        postDetailsToFirestore(
            firstName, secondName, playerNumber, height, weight, birthDate)
      };
    }
  }

  postDetailsToFirestore(
      String firstName,
      String secondName,
      String playerNumber,
      String height,
      String weight,
      DateTime birthDate) async {
    var info = Map<String, Object?>();
    bool anyFieldNotEmpty = false;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.uid = user!.uid;

    if (firstName != '') {
      info['firstName'] = firstName;
      anyFieldNotEmpty = true;
    }
    if (secondName != '') {
      info['secondName'] = secondName;
      anyFieldNotEmpty = true;
    }
    if (playerNumber != '') {
      info['playerNumber'] = int.parse(playerNumber);
      anyFieldNotEmpty = true;
    }
    if (height != '') {
      info['height'] = int.parse(height);
      anyFieldNotEmpty = true;
    }
    if (weight != '') {
      info['weight'] = int.parse(weight);
      anyFieldNotEmpty = true;
    }
    if (birthDate != '') {
      info['birthDate'] = birthDate;
      anyFieldNotEmpty = true;
    }
    if (anyFieldNotEmpty == true) {
      await firebaseFirestore.collection("users").doc(user.uid).update(info);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Profile()));
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Changes Applied'),
    ));
  }
}
