import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ this.uid });
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  final CollectionReference topicCollection =
      Firestore.instance.collection('topics');


  Future<void> updateUserData(String name) async {//,String newpassword
    return await userCollection.document(uid).setData({
//      if(password==)
      'uid': uid,
//      'password': password,
//      'password':newpassword,
      'name': name,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
    );
  }


  List<Topic> _topicListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Topic(
          name: doc.data['name'] ?? '',
          image: doc.data['image'] ?? ''
          );
    }).toList();
  }

Stream<UserData> get userData  {
try{
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }on Exception {

  return null;
  }
}

  Stream<List<Topic>> get topics {
    return topicCollection.snapshots().map(_topicListFromSnapshot);
  }
}

