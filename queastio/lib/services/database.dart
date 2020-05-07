import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:queastio/models/topic.dart';

class DatabaseService {
  final CollectionReference topicCollection =
      Firestore.instance.collection('topics');

  List<Topic> _topicListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Topic(
          name: doc.data['name'] ?? '', image: doc.data['image'] ?? '');
    }).toList();
  }

  Stream<List<Topic>> get topics {
    return topicCollection.snapshots().map(_topicListFromSnapshot);
  }
}
