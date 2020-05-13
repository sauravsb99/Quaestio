import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queastio/models/faq.dart';
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

  Future<void> updateUserDataByAdmin(String name, String image, String role) async {
      await userCollection.document(uid).setData({
      'uid': uid,
      'name': name,
      'image': image,
      'role':'admin',
    });
      return('True');
  }

  Future<void> updateQuiz(String name,String qTopic, List<Map> questions) async{
    return await quizCollection.document().setData({
      'name': name,
      'qTopic': qTopic,
      'questions': questions,
    });
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
        uname: doc.data['uname'] ?? '',
        qTopic: doc.data['qTopic'] ?? '',
        quiz: doc.data['quiz'] ?? '',
        score: doc.data['score'] ?? 0,
        total: doc.data['total'] ?? 0,
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
//  Stream<List<Score>> getScoresbyTopic() {
//    return scoreCollection
//        .where(('uid', isEqualTo: uid)).where(('quiz', isEqualTo: quiz)).orderBy('time', descending: true)
//        .snapshots()
//        .map(_scoreListFromSnapshot);
//  }
}
