import 'package:bloclist/db/functions/db_functions.dart';
import 'package:bloclist/presentation/Add/widgets/error_message.dart';
import 'package:bloclist/presentation/Add/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final nameController = TextEditingController();

final ageController = TextEditingController();

final placeController = TextEditingController();

final phoneController = TextEditingController();

class AddStudentsWidget extends StatelessWidget {
  AddStudentsWidget({super.key});
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
    ScaffoldMessenger.of(ctx).showSnackBar(mysnackBar);
  }

  getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    } else {
      path = pickedFile.path;
    }
  }
}

alertDelete(BuildContext ctx, index) {
  showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          // title: Text('Delete'),
          content: const Text('Do you want to delete this?'),
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
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      });
}
