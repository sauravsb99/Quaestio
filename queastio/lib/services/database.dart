import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/models/quiz.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  final CollectionReference topicCollection =
      Firestore.instance.collection('topics');

  final CollectionReference quizCollection =
      Firestore.instance.collection('quizzes');

  Future<void> updateUserData(String name) async {
    return await userCollection.document(uid).setData({
      'uid': uid,
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
          name: doc.data['name'] ?? '', image: doc.data['image'] ?? '');
    }).toList();
  }

  List<Quiz> _quizListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Quiz(
        qName: doc.data['name'] ?? '',
        qTopic: doc.data['qTopic'] ?? '',
        questions: List.from(doc.data['questions']) ?? List(),
      );
    }).toList();
  }

  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<Topic>> get topics {
    return topicCollection.snapshots().map(_topicListFromSnapshot);
  }

  Stream<List<Quiz>> getQuizzes(String topic) {
    return quizCollection
        .where('qTopic', isEqualTo: topic)
        .snapshots()
        .map(_quizListFromSnapshot);
  }
}
