import 'package:bloclist/presentation/HomeScreen/home_nav.dart';
import 'package:bloclist/presentation/StudentList/students_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageprovider = StateProvider<int>((ref) => 0);

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final _pages = [
    const HomeNav(),
    const StudentsNav(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
          final value = ref.watch(pageprovider);
      return
      Scaffold(
        body: _pages[value],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: value,
            onTap: (newindex) {
              ref.read(pageprovider.notifier).state = newindex;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'students',
              ),
            ]),
      );
    });
  }
}
