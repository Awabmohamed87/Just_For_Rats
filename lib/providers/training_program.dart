import 'package:flutter/material.dart';

import 'exercise.dart';

class TrainingProgram with ChangeNotifier {
  final String id;
  final String title;
  List<Exercise>? exercises = [];
  final Duration restDuration;

  TrainingProgram(this.id, this.title, this.restDuration, {this.exercises});
}
