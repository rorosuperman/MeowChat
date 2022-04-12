import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled1/Screens/WelcomeScreen.dart';
import 'package:untitled1/componets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//we bring the firebase out so the enter screen can asscess the instance
final _firestore = FirebaseFirestore.instance;
//similar way we bring out the loggedin user so that the entire app can use it
User? loggedinUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chatScreen';

  @override
  _ChatScreenState createState() =>
      _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //creating an instance of cloud firestore
//creating another auth instances
  final _auth = FirebaseAuth.instance;
//create a new firebase user variable called loggedinUser

  //now we have to check if the current user is the loggedin user

  //create a variable called message which takes the value of the messages typed
  String? messages;
  final messagecontroller =
      TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
//create a new method which checks for a current user which is signed in

  //once a user is successfully signed in then the credentials get stored in the _auth as a current user
  void getCurrentUser() async {
    try {
      //now we create a new final variable called user which is equal to auth.currentUser
      final user = await _auth.currentUser!;

      if (user != null) {
        loggedinUser = user;
        print(loggedinUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // //new method to get messages
  // void getMessages() async{
  //   //create a variable messages which holds the _firestore collection message get
  //   final messages =  await _firestore.collection('messages').get();
  //   //now we loop a message in messages in messages.docs
  //   for (var message in messages.docs){
  //     print (message.data());
  //   }
  // }

  void messageStream() async {
    //use the _firestore.collection('messages').snapshots
    //loop through the snapshots
    await for (var snapshot in _firestore
        .collection('messages')
        .snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //we have to use this to logout the user
                _auth.signOut();
                // //and send them
                Navigator.popAndPushNamed(
                    context, WelcomeScreen.id);
                //Implement logout functionality
              }),
        ],
        title: Text(
          'Psst...Psst....',
          style:
              TextStyle(color: Color(0xff383838)),
        ),
        backgroundColor: Color(0xffF49931),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
              CrossAxisAlignment.stretch,
          children: <Widget>[
            messagestream(),
            //we have to display the messages from the firestore
            //we use streambuilder
            //Streambuilder takes two properties
            //builder and stream

            Container(
              decoration:
                  kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller:
                          messagecontroller,
                      onChanged: (value) {
                        // set the value of the messages to the value of the textField
                        messages = value;
                        //Do something with the user input.
                      },
                      decoration:
                          kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messagecontroller.clear();
                      //sending the information to the firebase
                      //Implement send functionality.
                      //we call the firestore and tap into the collection library by its name and .add
                      _firestore
                          .collection('messages')
                          .add({
                        //the add is of a type map which takes string as a key which is excataly as we added in the firebase store and map the value of the data
                        'text': messages,
                        'sender':
                            loggedinUser?.email,
                        'time': FieldValue
                            .serverTimestamp()
                      });
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class messagestream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      //stream is the stream of data collected from firestore
      stream: _firestore
          .collection('messages')
          .orderBy('time', descending: false)
          .snapshots(),

      //builder will build context and because its stream builder it take snapshot
      builder: (BuildContext context,
          AsyncSnapshot snapshot) {
        //now we check if snapshot has data
        if (snapshot.hasData) {
          //then we create a variable called messages and and store the data docs in them
          final messages =
              snapshot.data?.docs.reversed;
          //  print (messages);
          //we create a list  called messageWidgets
          List<messageBubble> messageWidgets = [];
          // and loop through the messages in messages
          for (var message in messages!) {
            //create variable for messageText and add the data of text field
            final messageText =
                message.data()['text'];
            final messageSender =
                message.data()['sender'];
            // we create a variable called currentUser which is the loggedin user's email
            final currentUser =
                loggedinUser?.email;
            final messageTime = message
                .data()['time'] as Timestamp?;
            //we check if the currentuser is the logged in user
            if (currentUser == loggedinUser) {}
            final messageBubbles = messageBubble(
              sender: messageSender,
              text: messageText,
              time:messageTime,
              isMe: currentUser == messageSender,
            );
            messageWidgets.add(messageBubbles);
          }
          return Expanded(
            //listView
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: 20),
              children: messageWidgets,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class messageBubble extends StatelessWidget {
  messageBubble(
      {this.text, this.sender, this.isMe,this.time});
  final String? text;
  final String? sender;
  final bool? isMe;
  final Timestamp? time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
          crossAxisAlignment: isMe!
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text('$sender'),
            SizedBox(height: 6),
            Material(
              elevation: 5.0,
              borderRadius: isMe!
                  ? BorderRadius.only(
                      topLeft:
                          Radius.circular(30),
                      bottomLeft:
                          Radius.circular(30),
                      topRight:
                          Radius.circular(30))
                  : BorderRadius.only(
                      topLeft:
                          Radius.circular(30),
                      bottomRight:
                          Radius.circular(30),
                      topRight:
                          Radius.circular(30)),
              color: isMe!
                  ? Color(0xffF49931)
                  : Color(0xff383838),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  ' $text ',
                  style: TextStyle(
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: isMe!
                          ? Colors.black
                          : Colors.white),
                ),
              ),
            ),
          ]),
    );
    ;
  }
}
