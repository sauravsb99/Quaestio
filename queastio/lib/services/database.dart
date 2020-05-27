import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queastio/models/faq.dart';
import 'package:queastio/models/score.dart';
import 'package:queastio/models/topic.dart';
import 'package:queastio/models/user.dart';
import 'package:queastio/models/quiz.dart';
import 'package:queastio/models/batch.dart';
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

  final CollectionReference batchCollection =
      Firestore.instance.collection('batches');

  Future<void> updateUserData(
      String name, String image, String role, String batch) async {
    return await userCollection.document(uid).setData({
      'uid': uid,
      'name': name,
      'image': image,
      'role': role,
      'batch': batch,
    });
  }

  Future<void> updateBatchTopics(Batch batch) async {
    return await batchCollection.document(batch.bid).setData({
      'name': batch.name,
      'topics': batch.topics,
    });
  }

  Future<void> updateTopicBatches(
      String tid, String batchname, String action) async {
    return await topicCollection.document(tid).updateData({
      'batches': action == "add"
          ? FieldValue.arrayUnion([batchname])
          : FieldValue.arrayRemove([batchname]),
    });
  }

  Future<void> addTopic(
      String category, String image, String name, String batch) async {
    await topicCollection.document().setData({
      'uid': uid,
      'category': category,
      'image': image,
      'name': name,
      'batch': batch,
    });
    return ("true");
  }

  Future<void> addBatch(String name) async {
    await batchCollection.document().setData({
      'name': name,
      'topics': [],
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

  Future<void> deleteTopic() async {
    return topicCollection.document(uid).delete();
  }

  Future<void> deleteUser(String uid) async {
    var batch = Firestore.instance.batch();
    var docRef = userCollection.document(uid);
    await docRef.get().then((doc) {
      doc['scores'].forEach((scoreId) {
        print(scoreId);
        batch.delete(scoreCollection.document(scoreId));
      });
    });
    batch.delete(userCollection.document(uid));
    batch.commit();
  }

  Future<void> deleteScore(String uid) async {
    return scoreCollection.document(uid).delete();
  }

  Future<void> deleteBatch(String bid) async {
    return batchCollection.document(bid).delete();
  }

  Future<void> deleteQuiz(String qid) async {
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
    var db = Firestore.instance;
    var batch = db.batch();
    var docRef = scoreCollection.document();
    batch.setData(docRef, {
      'uid': uid,
      'uname': uname,
      'quiz': qname,
      'qTopic': qTopic,
      'score': score,
      'total': total,
      'time': time
    });

    batch.updateData(userCollection.document(uid), {
      'scores': FieldValue.arrayUnion([docRef.documentID])
    });

    batch.commit();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        image: snapshot.data['image'],
        role: snapshot.data['role'],
        batch: snapshot.data['batch']);
  }

  List<UserData> _userDataListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
        uid: doc['uid'],
        name: doc['name'],
        image: doc['image'],
        role: doc['role'],
        batch: doc['batch'],
      );
    }).toList();
  }

  List<Topic> _topicListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Topic(
        tid: doc.documentID,
        name: doc.data['name'] ?? '',
        image: doc.data['image'] ?? '',
        category: doc.data['category'] ?? '',
        batches: doc.data['batches'] ?? [],
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

  List<Batch> _batchListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Batch(
        bid: doc.documentID,
        name: doc.data['name'] ?? '',
        topics: doc.data['topics'] ?? [],
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
          .orderBy('name')
          .snapshots()
          .map(_userDataListFromSnapshot);
    } on Exception {
      return null;
    }
  }

  List<Faq> _faqListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Faq(
//          faqQid: doc.data['qid'] ?? '',
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

  Stream<List<Batch>> get batches {
    try {
      return batchCollection.snapshots().map(_batchListFromSnapshot);
    } on Exception {
      return null;
    }
  }

  Stream<List<Quiz>> getQuizzes(String topic) {
    return quizCollection
        .where('qTopic', isEqualTo: topic)
        .orderBy('name')
        .snapshots()
        .map(_quizListFromSnapshot);
  }

  Stream<List<Score>> getScores() {
    try {
      return scoreCollection
          .where('uid', isEqualTo: uid)
          .orderBy('time', descending: true)
          .snapshots()
          .map(_scoreListFromSnapshot);
    } on Exception {
      return null;
    }
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

  Stream<List<Topic>> getTopicsBatch(String batch) {
    return topicCollection
        .where('batches', arrayContains: batch)
        .snapshots()
        .map(_topicListFromSnapshot);
  }

  Stream<List<Score>> getTopicScoresAll(String topic) {
    if (topic == 'All' || topic == 'null') {
      return getScores();
    } else {
      return scoreCollection
          .where('qTopic', isEqualTo: topic)
          .snapshots()
          .map(_scoreListFromSnapshot);
    }
  }

  Stream<List<Score>> getQuizScores(String qname, String topic) {
    return scoreCollection
        .where('quiz', isEqualTo: qname)
        .where('qTopic', isEqualTo: topic)
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
}
