import 'package:bloclist/db/functions/db_functions.dart';
import 'package:bloclist/db/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class EditStudents extends StatefulWidget {
  EditStudents({super.key, required this.index, required this.data});

  int index;
  StudentModel data;

  @override
  State<EditStudents> createState() => _EditStudentsState();
}

class _EditStudentsState extends State<EditStudents> {
  String? path;
  TextEditingController? _nameController;
  TextEditingController? _ageController;
  TextEditingController? _placeController;
  TextEditingController? _phoneController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.data.name);

    _ageController = TextEditingController(text: widget.data.age);

    _placeController = TextEditingController(text: widget.data.place);

    _phoneController = TextEditingController(text: widget.data.phone);

    path = widget.data.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Edit Students'),
            ],
          ),
        ),
      ),
      body: Container(
        child: SafeArea(
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
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.abc_rounded),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 119, 118, 118),
                              width: 3.0),
                        ),
                        hintText: widget.data.name,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // ignore: prefer_const_constructors
                    TextField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.numbers),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 119, 118, 118),
                              width: 3.0),
                        ),
                        hintText: widget.data.age,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _placeController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_pin),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 119, 118, 118),
                              width: 3.0),
                        ),
                        hintText: widget.data.place,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 119, 118, 118),
                              width: 3.0),
                        ),
                        hintText: widget.data.phone,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        getImage();
                      },
                      label: Text('+'),
                      icon: Icon(Icons.photo),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.grey),
                      ),
                    ),

                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Edit(widget.index);
                        Navigator.pop(context);
                      },
                      label: Text('Save'),
                      icon: Icon(Icons.save),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Edit(int index) async {
    final _name = _nameController!.text.trim();
    final _age = _ageController!.text.trim();
    final _place = _placeController!.text.trim();
    final _phone = _phoneController!.text.trim();
    final _key = DateTime.now().toString();
    final image = path!;
    final _student = StudentModel(
        name: _name,
        age: _age,
        place: _place,
        phone: _phone,
        key: _key,
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
