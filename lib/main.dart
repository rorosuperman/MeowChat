import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Screens/ChatScreen.dart';
import 'Screens/RegisterScreen.dart';
import 'Screens/LoginScreen.dart';
import 'Screens/WelcomeScreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(FlashChat());
}


class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute:WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id :(context) => RegistrationScreen(),
        ChatScreen.id:(context) => ChatScreen(),
      },
    );
  }
}
