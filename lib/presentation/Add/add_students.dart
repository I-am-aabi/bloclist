import 'package:bloclist/db/functions/db_functions.dart';
import 'package:bloclist/db/model/data_model.dart';
import 'package:bloclist/presentation/StudentList/students_nav.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStudentsWidget extends StatefulWidget {
  AddStudentsWidget({super.key});

  @override
  State<AddStudentsWidget> createState() => _AddStudentsWidgetState();
}

class _AddStudentsWidgetState extends State<AddStudentsWidget> {
  String? path;

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _placeController = TextEditingController();

  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    'Add Students',
                    style: TextStyle(fontSize: 30),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.abc_rounded),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 119, 118, 118),
                            width: 3.0),
                      ),
                      hintText: 'Name',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  // ignore: prefer_const_constructors
                  TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.numbers),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 119, 118, 118),
                            width: 3.0),
                      ),
                      hintText: 'Age',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _placeController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_pin),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 119, 118, 118),
                            width: 3.0),
                      ),
                      hintText: 'Place',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.phone),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 0, 0, 0), width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 119, 118, 118),
                            width: 3.0),
                      ),
                      hintText: 'Phone Number',
                    ),
                  ),
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
                      AddButton(context);
                    },
                    label: const Text('Add'),
                    icon: const Icon(Icons.add),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AddButton(BuildContext ctx) {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _place = _placeController.text.trim();
    final _phone = _phoneController.text.trim();
    final _key = DateTime.now().toString();
    final _image = path;
    var field;

    ErrorMessage() {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red[300],
          content: Row(
            children: [
              Icon(Icons.error),
              Text('$field is empty'),
            ],
          ),
        ),
      );
    }

    if (_name.isEmpty &&
        _age.isEmpty &&
        _place.isEmpty &&
        _phone.isEmpty &&
        _image!.isEmpty) {
      field = 'Every field';
      ErrorMessage();
    } else if (_name.isEmpty) {
      field = 'Name';
      ErrorMessage();
    } else if (_age.isEmpty) {
      field = 'Age';
      ErrorMessage();
    } else if (_place.isEmpty) {
      field = 'Place';
      ErrorMessage();
    } else if (_phone.isEmpty) {
      field = 'Phone number';
      ErrorMessage();
    } else if (_image == null) {
      field = 'Image';
      ErrorMessage();
    } else {
      final _student = StudentModel(
        name: _name,
        age: _age,
        place: _place,
        phone: _phone,
        key: _key,
        image: _image,
      );
      addStudent(_student);
      _nameController.clear();
      _ageController.clear();
      _placeController.clear();
      _phoneController.clear();
    }
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

alertDelete(BuildContext ctx, index) {
  showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          // title: Text('Delete'),
          content: Text('Do you want to delete this?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (index != null) {
                  deleteStudent(index);
                  Navigator.pop(ctx);
                } else {
                  print('student id is null unable to delete');
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      });
}
