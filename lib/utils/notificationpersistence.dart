import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart' as path;
import 'package:vehispace/screens/offered_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreNotification {
  FirebaseAuth auth = FirebaseAuth.instance;
  Firestore firestore = Firestore.instance;

  Future<void> writeToStorage (List<Message> notification) async {
    final dir = await path.getApplicationDocumentsDirectory();
    final file = File('${dir.path}/notification.json');
//    if (file.parent.exists())
    return file.writeAsString(json.encode(notification.map((e) => e.toJson()).toList()));
  } 
  Future<List<Message>> readFromStorage () async {
    final dir = await path.getApplicationDocumentsDirectory();
    final file = File('${dir.path}/notification.json');
      if(await file.exists()) {
        final jsonStr = await file.readAsString();
        final decoded = json.decode(jsonStr);
        return decoded.map<Message>((x) => Message.fromJson(x)).toList();
      }else {
        return <Message>[];
      }
  }

  save(String key, List<Message> value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  userNotification (Message message) async {
    final user = await auth.currentUser();
    final not = firestore.collection('usermanagement').document(user.uid).collection('notification').document().setData({
      'title': message.title,
      'body': message.body,
      'message': message.message,
      'date': message.date,
    });
  }

}