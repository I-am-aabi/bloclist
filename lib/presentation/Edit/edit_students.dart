import 'package:bloclist/db/functions/db_functions.dart';
import 'package:bloclist/db/model/data_model.dart';
import 'package:bloclist/presentation/Add/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../Add/add_students.dart';

class EditStudents extends StatefulWidget {
  EditStudents({super.key, required this.index, required this.data});

  int index;
  StudentModel data;

  @override
  State<EditStudents> createState() => _EditStudentsState();
}

class _EditStudentsState extends State<EditStudents> {
  String? path;
  @override
  void initState() {
    nameController.text = widget.data.name;
    ageController.text = widget.data.age;
    placeController.text = widget.data.place;
    phoneController.text = widget.data.phone;
    path = widget.data.image;
    path = widget.data.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: FileImage(
                      File(widget.data.image),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextField(
                      controller: nameController,
                      hint: widget.data.name,
                      icon: Icons.abc_rounded),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: ageController,
                      hint: widget.data.age,
                      icon: Icons.numbers),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: placeController,
                      hint: widget.data.place,
                      icon: Icons.location_on),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: phoneController,
                      hint: widget.data.phone,
                      icon: Icons.phone),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      getImage();
                    },
                    label: const Text('+'),
                    icon: const Icon(Icons.photo),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Edit(widget.index);
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

  Future<void> Edit(int index) async {
    final name = nameController.text.trim();
    final age = ageController.text.trim();
    final place = placeController.text.trim();
    final phone = phoneController.text.trim();
    final key = DateTime.now().toString();
    final image = path!;
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
    var path;
    final PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (PickedFile == null) {
      return;
    } else {
      setState(() {
        this.path = PickedFile.path;
      });
    }
  }
}
