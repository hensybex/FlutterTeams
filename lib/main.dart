import 'package:black_pearl/pages/profile/profile.dart';
import 'package:black_pearl/pages/profile/update_profile.dart';
import 'package:black_pearl/pages/home/home_screen.dart';
import 'package:black_pearl/pages/auth/register_screen.dart';
import 'package:black_pearl/pages/test/test.dart';
import 'package:black_pearl/sevices/auth.dart';
import 'package:flutter/material.dart';
import 'package:black_pearl/pages/todo.dart';
import 'package:black_pearl/pages/squad_builder/squad_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:black_pearl/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:black_pearl/pages/auth/login_screen.dart';
import 'package:black_pearl/pages/player_list/player_list.dart';
import 'package:black_pearl/pages/calendar/calendar.dart';

void initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_) => AuthService(),
          ),
        ],
        child: MaterialApp(
            title: 'Flutter Auth Example',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: './login',
            routes: {
              //'./': (context) => Wrapper(),
              './login': (context) => LoginScreen(),
              './register': (context) => RegisterScreen(),
              './todo': (context) => ToDo(),
              './home': (context) => HomeScreen(),
              './squad_builder': (context) => SquadBuilder(),
              './player_list': (context) => PlayerList(),
              './calendar': (context) => Calendar(),
              './profile': (context) => Profile(),
              './update_profile': (context) => UpdateProfile(),
              './test': (context) => TestPage(),
              //'./player': (context) => Player(id: '',),
              //'./coach': (context) => Coach(),
            }));
  }
}
