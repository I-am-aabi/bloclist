// ignore_for_file: non_constant_identifier_names

import 'package:bloclist/db/functions/db_functions.dart';
import 'package:bloclist/db/model/data_model.dart';
import 'package:bloclist/presentation/Add/widgets/text_field.dart';
import 'package:bloclist/presentation/StudentList/students_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../Add/add_students.dart';

class EditStudents extends StatelessWidget {
  EditStudents({super.key, required this.index, required this.data});

  int index;
  StudentModel data;

  String? path;

  @override
  Widget build(BuildContext context) {
    nameController.text = data.name;
    ageController.text = data.age;
    placeController.text = data.place;
    phoneController.text = data.phone;
    path = data.image;
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Edit Students'),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Consumer(builder: (context, ref, child) {
                    final value = ref.watch(imageProvider);
                    return CircleAvatar(
                      radius: 90,
                      backgroundImage: FileImage(
                        File(value),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                      controller: nameController,
                      hint: data.name,
                      icon: Icons.abc_rounded),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: ageController,
                      hint: data.age,
                      icon: Icons.numbers),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: placeController,
                      hint: data.place,
                      icon: Icons.location_on),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: phoneController,
                      hint: data.phone,
                      icon: Icons.phone),
                  const SizedBox(
                    height: 8,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return ElevatedButton.icon(
                        onPressed: () async {
                          path = await getImage();
                          ref.read(imageProvider.notifier).state = path!;
                        },
                        label: const Text('+'),
                        icon: const Icon(Icons.photo),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Edit(index, path);
                      Navigator.pop(context);
                    },
                    label: const Text('Save'),
                    icon: const Icon(Icons.save),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Edit(int index, value) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final place = placeController.text.trim();
    final phone = phoneController.text.trim();
    final key = DateTime.now().toString();
    final image = value;
    final _student = StudentModel(
        name: name,
        age: age,
        place: place,
        phone: phone,
        key: key,
        image: image);
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.putAt(index, _student);
    getAllStudents();
  }

  getImage() async {
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile == null) {
      return;
    } else {
      return PickedFile.path;
    }
  }
}
