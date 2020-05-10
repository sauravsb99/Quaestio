import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queastio/models/score.dart';
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
  final CollectionReference scoreCollection =
      Firestore.instance.collection('scores');

  Future<void> updateUserData(String name, String image) async {
    return await userCollection.document(uid).setData({
      'uid': uid,
      'name': name,
      'image': image,
    });
  }

  Future<void> insertScore(String qname, int score, int total) async {
    return await scoreCollection.document().setData({
      'uid': uid,
      'quiz': qname,
      'score': score,
      'total': total,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      image: snapshot.data['image'],
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
        qId: doc.documentID,
        qName: doc.data['name'] ?? '',
        qTopic: doc.data['qTopic'] ?? '',
        questions: List.from(doc.data['questions']) ?? List(),
      );
    }).toList();
  }

  List<Score> _scoreListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Score(
        uid: doc.data['uid'] ?? '',
        quiz: doc.data['quiz'] ?? '',
        score: doc.data['score'] ?? 0,
        total: doc.data['total'] ?? 0,
      );
    }).toList();
  }

  Stream<UserData> get userData {
    try {
      return userCollection
          .document(uid)
          .snapshots()
          .map(_userDataFromSnapshot);
    } on Exception {
      return null;
    }
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

  Stream<List<Score>> getScores() {
    return scoreCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_scoreListFromSnapshot);
  }
}
