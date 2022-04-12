import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/Screens/ChatScreen.dart';
import 'package:untitled1/componets.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/componets/roundbutton.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginScreen';
  @override
  _LoginScreenState createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {
  //initialise firbase as _Auth

  final _auth = FirebaseAuth.instance;
  //create email and password variables for the user to enter
  String? email;
  String? password;
  //create a boolean variable to set for the modal progress
  bool setSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: setSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24.0),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: "logo",
                child: Container(
                  height: 200.0,
                  child: Image.asset(
                      'images/Logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  keyboardType:
                      TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                    //Do something with the user input.
                  },
                  decoration: kinputDeco.copyWith(
                      hintText:
                          "Enter your Email")),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  textAlign: TextAlign.center,
                  obscureText: true,
                  onChanged: (value) {
                    //Do something with the user input.
                    password = value;
                  },
                  decoration: kinputDeco.copyWith(
                      hintText:
                          "Enter your Password")),
              SizedBox(
                height: 24.0,
              ),
              Roundedbutton(
                onpressed: () async {
                  setState(() {
                    setSpinner = true;
                  });
                  try {
                    //here we use the sign in
                    final user = await _auth.signInWithEmailAndPassword(
                            email: email!,
                            password: password!);

                    if (user != null) {
                      Navigator.pushNamed(
                          context, ChatScreen.id);
                    }
                    setState(() {
                      setSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
                style: kLoginTextStyle,
                title: "Login",
                colors: Color(0xffFAAC31),
              )
            ],
          ),
        ),
      ),
    );
  }
}
