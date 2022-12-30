import 'package:bloclist/db/functions/db_functions.dart';
import 'package:bloclist/db/model/data_model.dart';
import 'package:bloclist/presentation/student_details/student_details.dart';
import 'package:bloclist/presentation/Add/add_students.dart';
import 'package:bloclist/presentation/Edit/edit_students.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

import '../search/search_students.dart';

var imageProvider = StateProvider<String>(((ref) => ''));
class StudentsNav extends StatelessWidget {
  const StudentsNav({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder:
          (BuildContext ctx, List<StudentModel> studentList, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Student List'),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>  SearchScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: studentList.length,
            itemBuilder: (context, index) {
              final data = studentList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(
                    File(data.image),
                  ),
                ),
                title: Text(data.name),
                subtitle: Text(data.place),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) {
                        return ShowDetails(data: data);
                      }),
                    ),
                  );
                },
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (data.key != null) {
                          alertDelete(ctx, index);
                        } else {
                          print('No key found.');
                        }
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        imageProvider =
                            StateProvider<String>(((ref) => data.image));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditStudents(index: index, data: data),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
