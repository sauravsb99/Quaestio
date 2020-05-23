class Scoring {
  final List questions, selected;
  Scoring({this.questions, this.selected});

  int getScore() {
    int count = 0;
    for (int i = 0; i < questions.length; ++i) {
      if (questions[i]['answer'] == selected[i]) count++;
    }
    return count;
  }
}
