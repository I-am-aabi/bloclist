import 'package:bloclist/db/functions/db_functions.dart';
import 'package:bloclist/presentation/Add/widgets/error_message.dart';
import 'package:bloclist/presentation/Add/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final nameController = TextEditingController();

final ageController = TextEditingController();

final placeController = TextEditingController();

final phoneController = TextEditingController();

class AddStudentsWidget extends StatefulWidget {
  AddStudentsWidget({super.key});

  @override
  State<AddStudentsWidget> createState() => _AddStudentsWidgetState();
}

class _AddStudentsWidgetState extends State<AddStudentsWidget> {
  String? path;

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
                  MyTextField(
                      controller: nameController,
                      hint: 'Name',
                      icon: Icons.abc_rounded),
                  const SizedBox(
                    height: 8,
                  ),
                  // ignore: prefer_const_constructors
                  MyTextField(
                      controller: ageController,
                      hint: 'Age',
                      icon: Icons.numbers),
                  const SizedBox(
                    height: 8,
                  ),
                  MyTextField(
                      controller: placeController,
                      hint: 'Place',
                      icon: Icons.location_pin),
                  const SizedBox(
                    height: 8,
                  ),
                MyTextField(
                      controller: phoneController,
                      hint: 'Phone Number',
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
    List data = [
      nameController.text.trim(),
      ageController.text.trim(),
      placeController.text.trim(),
      phoneController.text.trim(),
      path,
      DateTime.now().toString()
    ];
    SnackBar mysnackBar = CheckError(data);
    ScaffoldMessenger.of(context).showSnackBar(mysnackBar);
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
