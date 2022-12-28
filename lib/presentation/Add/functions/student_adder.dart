import 'package:bloclist/db/model/data_model.dart';

import '../../../db/functions/db_functions.dart';
import '../add_students.dart';

StudentAdder(List data){
    final _student = StudentModel(
        name: data[0],
        age: data[1],
        place: data[2],
        phone: data[3],
        key: data[5],
        image: data[4],
      );
      addStudent(_student);
      nameController.clear();
      ageController.clear();
      placeController.clear();
      phoneController.clear();
}