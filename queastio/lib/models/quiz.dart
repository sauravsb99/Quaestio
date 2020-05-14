class Quiz {
  final String qId;
  final String qName;
  final String qTopic;
  final String qDesc;
  final int duration;
  final int qCount;
  final List questions;

  Quiz({
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
  String name;
  String qTopic;
  List questions;
  Map m;
  Quizadd({this.name, this.qTopic, this.questions, this.m});
}
