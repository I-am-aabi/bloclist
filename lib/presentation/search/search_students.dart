import 'package:bloclist/db/model/data_model.dart';
import 'package:bloclist/presentation/student_details/student_details.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';

final List<StudentModel> studentBoxList =
    Hive.box<StudentModel>('student_db').values.toList();
final searchprovider =
    StateProvider<List<StudentModel>>(((ref) => studentBoxList));

class SearchScreen extends ConsumerWidget {
  SearchScreen({Key? key}) : super(key: key);

  final _searchController = TextEditingController();

  final List<StudentModel> studentBoxList =
      Hive.box<StudentModel>('student_db').values.toList();

  late List<StudentModel> displayStudent =
      List<StudentModel>.from(studentBoxList);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(searchprovider);
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
                  ref.read(searchprovider.notifier).state = studentBoxList
                      .where((element) => element.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                  displayStudent = values;
                },
              ),
            ),
            Expanded(
              child: (displayStudent.isNotEmpty)
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

  goto(int index, ctx) async {
    final studentBoxList = await Hive.openBox<StudentModel>('Student');

    final stud = studentBoxList.getAt(index);
    if (stud == null) {
      return const Text('null');
    } else {
      return Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (ctx) => ShowDetails(
            data: stud,
          ),
        ),
      );
    }
  }
}
