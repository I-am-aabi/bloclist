import 'package:bloclist/db/model/data_model.dart';
import 'package:bloclist/presentation/student_details/student_details.dart';

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  final List<StudentModel> studentBoxList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> displayStudent =
      List<StudentModel>.from(studentBoxList);

  void searchStudentList(String value) {
    setState(() {
      displayStudent = studentBoxList
          .where((element) =>
              element.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Students"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 7),
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Search'),
                controller: _searchController,
                onChanged: (value) {
                  searchStudentList(value);
                },
              ),
            ),
            Expanded(
              child: (displayStudent.length != 0)
                  ? ListView.separated(
                      itemBuilder: (context, index) {
                        File imageFile = File(displayStudent[index].image);
                        return ListTile(
                          // onTap: () async {
                          //   goto(index);
                          // },
                          leading: CircleAvatar(
                            backgroundImage: FileImage(imageFile),
                            radius: 20,
                          ),
                          title: Text(displayStudent[index].name),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return const Divider();
                      },
                      itemCount: displayStudent.length,
                    )
                  : const Center(child: Text("The data is not Found")),
            ),
          ],
        ),
      ),
    );
  }

  goto(int index) async {
    final studentBoxList = await Hive.openBox<StudentModel>('Student');

    final stud = studentBoxList.getAt(index);
    if (stud == null) {
      return const Text('null');
    } else {
      return Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ShowDetails(
            data: stud,
          ),
        ),
      );
    }
  }
}
