import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:black_pearl/models/user_model.dart';
import 'package:black_pearl/pages/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  _RegisterScreenState();

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  var role = "Player";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create your account'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  enabled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email cannot be empty";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please enter a valid email");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  enabled: true,
                ),
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  }
                  if (!regex.hasMatch(value)) {
                    return ("please enter valid password min. 6 character");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: confirmpassController,
                decoration: InputDecoration(
                  labelText: "Confirm Password",
                  enabled: true,
                ),
                validator: (value) {
                  if (confirmpassController.text != passwordController.text) {
                    return "Password did not match";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: firstNameController,
                decoration: InputDecoration(
                  labelText: "First Name",
                  enabled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "First name cannot be empty";
                  }
                  if (!RegExp("^[a-zA-Z]").hasMatch(value)) {
                    return ("Please enter valid first name");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
                keyboardType: TextInputType.name,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: secondNameController,
                decoration: InputDecoration(
                  labelText: "Second Name",
                  enabled: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Second name cannot be empty";
                  }
                  if (!RegExp("^[a-zA-Z]").hasMatch(value)) {
                    return ("Please enter valid second name");
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {},
                keyboardType: TextInputType.name,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                signUp(emailController.text, passwordController.text,
                    firstNameController.text, secondNameController.text, role);
              },
              /*onPressed: () async {
                await authService.createUserWithEmailAndPass(
                  emailController.text,
                  passwordController.text,
                );
                Navigator.pop(context);
              },*/
              child: Text('Register'),
            )
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password, String firstName,
      String secondName, String role) async {
    CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              {postDetailsToFirestore(email, firstName, secondName, role)})
          .catchError((e) {
        return e.message;
        //print(e.message); // code, message, details
      });
    }
  }

  postDetailsToFirestore(
      String email, String firstName, String secondName, String role) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.email = email;
    userModel.firstName = firstName;
    userModel.secondName = secondName;
    userModel.playerNumber = null;
    userModel.height = null;
    userModel.weight = null;
    userModel.birthDate = DateTime(1900);
    userModel.assists = 0;
    userModel.goalsScored = 0;
    userModel.gamesPlayed = 0;
    userModel.uid = user!.uid;
    userModel.wrole = role;
    userModel.onBench = true;
    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
