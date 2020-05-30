class Quiz {
  final String uid;
  final String qId;
  final String type;
  final String stype;
  final String qName;
  final String qTopic;
  final String qDesc;
  final int duration;
  final int qCount;
  final List questions;

  Quiz({
    this.type,
    this.stype,
    this.uid,
    this.qId,
    this.qName,
    this.qTopic,
    this.questions,
    this.duration,
    this.qCount,
    this.qDesc,
  });
}

class Quizadd {
  String type;
  String stype;
  String uid;
  String name;
  String qTopic;
  List questions;
  Map m;
  Quizadd({this.type,this.stype,this.uid, this.name, this.qTopic, this.questions, this.m});
}
