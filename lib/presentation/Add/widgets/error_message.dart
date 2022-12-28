import 'package:bloclist/presentation/Add/functions/error_check.dart';
import 'package:bloclist/presentation/Add/functions/student_adder.dart';
import 'package:flutter/material.dart';

SnackBar CheckError(List data) {
  String field = ErrorCheck(data);
  if (field != 'success') {
    SnackBar mysnackBar = SnackBar(
      backgroundColor: Colors.red[300],
      content: Row(
        children: [
          const Icon(Icons.error),
          Text('$field is empty'),
        ],
      ),
    );

    return mysnackBar;
  } else {
    StudentAdder(data);
    SnackBar mysnackBar = SnackBar(
      backgroundColor: const Color.fromARGB(255, 56, 201, 124),
      content: Row(
        children: const [
          Icon(Icons.done),
          Text('Succcessfully added'),
        ],
      ),
    );
    return mysnackBar;
  }
}
