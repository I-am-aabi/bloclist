
import 'package:bloclist/presentation/Add/add_students.dart';
import 'package:flutter/material.dart';

class HomeNav extends StatelessWidget {
  const HomeNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: AddStudentsWidget(),
      ),
    );
  }
}
