//import 'package:flutter/material.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:vehispace/screens/notification.dart';
//
//class FirebaseMessagingTest extends StatefulWidget {
//  @override
//  _FirebaseMessagingTestState createState() => _FirebaseMessagingTestState();
//}
//
//class _FirebaseMessagingTestState extends State<FirebaseMessagingTest> {
//
//  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//
//  List<Message> _messages;
//
//  getToken () async {
//   await _firebaseMessaging.getToken().then((deviceToken){
//      print(deviceToken.toString());
//    });
//  }
//
//  configureFirebaseListeners () {
//    _firebaseMessaging.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print('onMessage $message');
//        _setMessage(message);
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print('onLaunch $message');
//        _setMessage(message);
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print('onResume $message');
//        _setMessage(message);
//      },
//    );
//  }
//
//  _setMessage(Map<String, dynamic> message) {
//    final notification = message['notification'];
//    final data = message['data'] ?? message;
//    final String title = notification['title'];
//    final String body = notification['body'];
//    final String dataMessage = data['message'];
//    setState(() {
//       Message m = Message(title, body, dataMessage);
//       _messages.add(m);
//    });
//    Navigator.push(context, MaterialPageRoute(builder: (context) => MyNotification(
//      message: _messages,
//    )));
// }
//
//  @override
//
//  void initState() {
//    super.initState();
//    _messages = List<Message>();
//    getToken();
//    configureFirebaseListeners();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return ListView.builder(
//      itemCount: null == _messages ? 0 : _messages.length,
//      itemBuilder: (context, index){
//        return Card(
//          child:  Column(
//            children: <Widget>[
//              Text(_messages[index].title),
//              Text(_messages[index].body),
//              Text(_messages[index].message),
//            ],),
//        );
//      },
//    );
//  }
//}
//
//class Message {
//  String title;
//  String body;
//  String message;
//
//  Message (
//    this.title,
//    this.body,
//    this.message
//  );
//}