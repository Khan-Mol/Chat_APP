import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/Utilities/assets_manager.dart';
import 'package:flutter_chat_app/main_screen/Appointment_tutor.dart';
import 'package:flutter_chat_app/main_screen/Appointment_tutor.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
  int _currentIndex = 0; // Track the current index of the BottomNavigationBar
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: AssetImage(AssetsManager.userImage),
            ),
          )
        ],
      ),
      body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children:[
            Center(
              child: Text('Chats'),
            ),
            Center(
              child: TutorScreen(),
            ),
            Center(
              child: Text('People'),
            )
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2_fill),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.calendar),
            label: 'Appointments',
          ),

          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.globe),
            label: 'People',
          ),
        ],
        currentIndex: _currentIndex, // Reflect the current tab selection
        type: BottomNavigationBarType.fixed, // Fixes spacing issues
        onTap: (index) {
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeIn);
          setState(() {
            _currentIndex = index; // Update the index to reflect the active tab
          });
        },
      ),
    );
  }
}
