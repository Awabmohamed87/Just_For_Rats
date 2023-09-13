import 'package:flutter/material.dart';
import 'package:just_for_rats/providers/training_program.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  String? name;
  int? age;
  double? weight;
  double? height;
  List<TrainingProgram> trainingPrograms = [
    TrainingProgram('0', 'Pro Split', const Duration(seconds: 10))
  ];

  registerUser({name, age, weight, height}) async {
    this.name = name;
    this.age = age;
    this.weight = weight;
    this.height = height;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setInt('age', age);
    prefs.setDouble('weight', weight);
    prefs.setDouble('height', height);
  }

  setFirstProgram(String title, {List<String>? days}) {
    print(title);
    print(days!.length);
  }
}
