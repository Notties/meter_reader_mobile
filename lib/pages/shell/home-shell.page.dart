import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_reader_mobile/controller/nav/nav.controller.dart';
import 'package:meter_reader_mobile/pages/reading/reading-form.page.dart';
import 'package:meter_reader_mobile/pages/reading/reading-list.page.dart';
import 'package:meter_reader_mobile/pages/user/user.page.dart';

class HomeShellPage extends StatelessWidget {
  const HomeShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = Get.put(NavController(), permanent: true);
    final pages = const [ReadingListPage(), ReadingFormPage(), UserPage()];

    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          if (!nav.isFirstTab()) {
            nav.to(0);
            return false;
          }
          return true;
        },
        child: Scaffold(
          extendBody: true,
          body: IndexedStack(index: nav.current.value, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            iconSize: 32,
            currentIndex: nav.current.value,
            onTap: nav.to,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined),
                activeIcon: Icon(Icons.list_alt),
                label: 'รายการ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline),
                activeIcon: Icon(Icons.add_circle),
                label: 'เพิ่ม',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'ผู้ใช้',
              ),
            ],
          ),
        ),
      );
    });
  }
}
