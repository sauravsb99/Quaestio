import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final Timestamp timestamp;
  User({this.uid,this.timestamp});
}

class UserData {

  final String uid;
  final String name;
  final String image;
  final String role;
  final String batch;
  final String resume;
  

  UserData({ this.uid,this.name,this.image,this.role,this.batch,this.resume});

}
