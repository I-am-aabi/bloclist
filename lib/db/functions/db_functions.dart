// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:bloclist/db/model/data_model.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

Future<void> addStudent(StudentModel value) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
  final _key = await studentDB.add(value);
  studentListNotifier.value.add(value);
  // ignore: invalid_use_of_protected_member
  studentListNotifier.notifyListeners();
}

Future<void> getAllStudents() async {
  // ignore: no_leading_underscores_for_local_identifiers, unused_local_variable
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  studentListNotifier.value.clear();
  studentListNotifier.value.addAll(studentDB.values);
   // ignore: invalid_use_of_protected_member
  studentListNotifier.notifyListeners();
}

Future<void> deleteStudent(int key) async {
  final studentDB = await Hive.openBox<StudentModel>('student_db');
  await studentDB.deleteAt(key);
  // Text("Age : ${studentDB.get('name').where}")
  getAllStudents();
}

