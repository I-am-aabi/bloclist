// ignore_for_file: non_constant_identifier_names

import 'package:bloclist/db/model/data_model.dart';

import '../../../db/functions/db_functions.dart';
import '../add_students.dart';

StudentAdder(List data){
    final student = StudentModel(
        name: data[0],
        age: data[1],
        place: data[2],
        phone: data[3],
        key: data[5],
        image: data[4],
      );
      addStudent(student);
      nameController.clear();
      ageController.clear();
      placeController.clear();
      phoneController.clear();
}