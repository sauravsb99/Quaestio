import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queastio/models/faq.dart';
import 'package:queastio/models/score.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/models/quiz.dart';
import 'dart:developer' as developer;

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

  final CollectionReference faqCollection =
      Firestore.instance.collection('faq');

  Future<void> updateUserData(String name, String image, String role) async {
    return await userCollection.document(uid).setData({
      'uid': uid,
      'name': name,
      'image': image,
      'role': role,
    });
  }

  Future<void> updateUserDataByAdmin(
      String name, String image, String role) async {
    await userCollection.document(uid).setData({
      'uid': uid,
      'name': name,
      'image': image,
      'role': 'admin',
    });
    return ('True');
  }

  Future<void> updateQuiz(String name, String qTopic, String qDesc, int qCount,
      int duration, List<Map> questions) async {
    return await quizCollection.document().setData({
      'uid': uid,
      'name': name,
      'qTopic': qTopic,
      'qDesc': qDesc,
      'qCount': qCount,
      'duration': duration,
      'questions': questions,
    });
  }
Future<void> deleteUser(String uid) async {
    return userCollection.document(uid).delete();
  }
  Future<void> deleteQuiz(String qid) async {
    print('ok');
    quizCollection.document(qid).delete();
  }

//  Stream<List<Quiz>>
  String selectedQuiz(String name, String topic) {
//    var a=quizCollection.where('name',isEqualTo: name).where('qTopic',isEqualTo: topic);
    var a = quizCollection.document().documentID;
    print(a);
    return a;
//        .where('name',isEqualTo: name).where('qTopic',isEqualTo: topic);
  }

  Stream<List<Quiz>> getQuizzesadmin(String uid) {
    return quizCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_quizListFromSnapshot);
  }

  Future<void> insertScore(String uname, String qname, String qTopic, int score,
      int total, DateTime time) async {
    return await scoreCollection.document().setData({
      'uid': uid,
      'uname': uname,
      'quiz': qname,
      'qTopic': qTopic,
      'score': score,
      'total': total,
      'time': time
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      image: snapshot.data['image'],
      role: snapshot.data['role'],
    );
  }

  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        uid: doc['uid'],
        name: doc['name'],
        image: doc['image'],
        role: doc['role'],
      );
    }).toList();
  }

  List<Topic> _topicListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Topic(
        name: doc.data['name'] ?? '',
        image: doc.data['image'] ?? '',
        category: doc.data['category'] ?? '',
      );
    }).toList();
  }
  
  List<Quiz> _quizListFromSnapshot(QuerySnapshot snapshot) {
    developer.log('Hi');
    return snapshot.documents.map((doc) {
      developer.log(doc.documentID);
      return Quiz(
        qId: doc.documentID,
        qName: doc.data['name'] ?? '',
        qTopic: doc.data['qTopic'] ?? '',
        questions: List.from(doc.data['questions']) ?? List(),
        qDesc: doc.data['qDesc'] ?? 'A Simple Quiz',
        duration: doc.data['duration'] ?? 10,
        qCount: doc.data['qCount'] ?? 0,
      );
    }).toList();
  }

  List<Score> _scoreListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Score(
        uid: doc.data['uid'] ?? '',
        uname: doc.data['uname'] ?? '',
        qTopic: doc.data['qTopic'] ?? '',
        quiz: doc.data['quiz'] ?? '',
        score: doc.data['score'] ?? '',
        total: doc.data['total'] ?? '',
        time: doc.data['time'] ?? '',
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

  Stream<List<UserData>> get allUsers {
    try {
      return userCollection
          .where('role', isEqualTo: 'user')
          .snapshots()
          .map(_userDataListFromSnapshot);
    } on Exception {
      return null;
    }
  }

  List<Faq> _faqListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Faq(
          faqQid: doc.data['qid'] ?? '',
          faqQuestion: doc.data['question'] ?? '',
          faqAnswer: doc.data['answer'] ?? '');
    }).toList();
  }

  Stream<List<Topic>> get topics {
    return topicCollection.snapshots().map(_topicListFromSnapshot);
  }

  Stream<List<Faq>> get faqs {
    return faqCollection.snapshots().map(_faqListFromSnapshot);
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
        .orderBy('time', descending: true)
        .snapshots()
        .map(_scoreListFromSnapshot);
  }

  Stream<List<Score>> getTopicScores(String topic) {
    if (topic == 'All' || topic == 'null') {
      return getScores();
    } else {
      return scoreCollection
          .where('uid', isEqualTo: uid)
          .where('qTopic', isEqualTo: topic)
          .orderBy('time', descending: true)
          .snapshots()
          .map(_scoreListFromSnapshot);
    }
  }

  Stream<List<Score>> getQuizScores(String qname) {
    return scoreCollection
        .where('quiz', isEqualTo: qname)
        .orderBy('score', descending: true)
        .snapshots()
        .map(_scoreListFromSnapshot);
  }

  Future<QuerySnapshot> testAlreadyTaken(String qname) async {
    return scoreCollection
        .where('uid', isEqualTo: uid)
        .where('quiz', isEqualTo: qname)
        .getDocuments();
  }

//  void deletequiz(BuildContext context, String name) async {
//    await notesReference.child(note.id).remove().then((_) {
//      setState(() {
//        items.removeAt(position);
//      });
//    });
//  }

//  Stream<List<Score>> getScoresbyTopic() {
//    return scoreCollection
//        .where(('uid', isEqualTo: uid)).where(('quiz', isEqualTo: quiz)).orderBy('time', descending: true)
//        .snapshots()
//        .map(_scoreListFromSnapshot);
//  }
}

//bool deletequiz(String name) {
//  try {
//    data.quizCollection
//        .document()
//        .delete();
//    return true;
//  } catch (e) {
//    print(e.toString());
//    return false;
//  }
//}
