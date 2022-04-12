import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled1/componets.dart';
import 'package:untitled1/componets/roundbutton.dart';
import 'ChatScreen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';


class RegistrationScreen extends StatefulWidget {
  static const String id = 'registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  //we create an instance of firebase
  final _auth = FirebaseAuth.instance;
//create two variables for email and password
  String? email;
  String? password;
  //the bool variable for modal progress
  bool showspinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo' ,
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/Logo.png'),
                ),
              ),
               const SizedBox(
                height: 48.0,
              ),
              TextField(
                //now we align the text
                textAlign: TextAlign.center,
                //set the keyboard type to email
                keyboardType: TextInputType.emailAddress,
                // in on-changed set email variable to the value
                onChanged: (value) {
                  email = value;
                },
                decoration: kinputDeco.copyWith(hintText: "Enter E-mail ID"),
              ),
             const  SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                // keyboardType: TextInputType.emailAddress,
                //for passward
                obscureText: true,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kinputDeco.copyWith(hintText: "Enter your password"),
              ),
             const  SizedBox(
                height: 24.0,
              ),
              //final button to register
              Roundedbutton(
                //when pressed
                onpressed: () async {
                  setState(() {
                    showspinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email!, password: password!);
                    if (newUser != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showspinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }

                  // print (email);
                  // print(password);
                },
                colors: Color(0xff383838),
                title: 'Register',
                style: kRegisterTextStyle,
              )
            ],
          ),
        ),
      ),
    );
  }
}
