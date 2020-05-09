class Scoring {
  final List answers, selected;
  Scoring({this.answers, this.selected});

  int getScore() {
    int count = 0;
    for (int i = 0; i < answers.length; ++i) {
      if (answers[i] == selected[i]) count++;
    }
    return count;
  }
}
