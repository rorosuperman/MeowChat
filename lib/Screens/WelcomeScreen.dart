// ignore_for_file: deprecated_member_use


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/componets.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../componets/roundbutton.dart';
import 'LoginScreen.dart';
import 'RegisterScreen.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();


    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
      //upperBound: 100,
    );
    // animation = ColorTween(begin: Colors.red,end: Colors.grey).animate(controller);
    // animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    controller!.forward();

    controller!.addListener(() {
      setState(() {this;});
      print(animation!.value);
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('images/Logo.png'),
                    height: 120,
                  ),
                ),
                SizedBox(height: 12,),
                TypewriterAnimatedTextKit(text: ['MeowChat'], textStyle: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w900,fontFamily: 'Helvetica'

                ),
                  speed: const Duration(milliseconds: 400 ),
                  pause: const Duration(seconds: 1),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text('Psst...Psst',style: TextStyle(fontSize: 15,fontFamily: 'Helvetica'),),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Roundedbutton(onpressed:(){
              Navigator.pushNamed(context, LoginScreen.id);
            },
              title: "login",colors: Color(0xffFAAC31),style:kLoginTextStyle,),
            Roundedbutton(onpressed:(){
              Navigator.pushNamed(context,RegistrationScreen.id);
            },colors: Color(0xff383838),title:'Register',style:kRegisterTextStyle),
          ],
        ),
      ),
    );
  }
}
