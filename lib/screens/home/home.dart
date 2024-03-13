import 'package:duochat/assistant_methode/size_config.dart';
import 'package:duochat/presentation/colors/color_manager.dart';
import 'package:duochat/presentation/components/alert_dialog/discussion_name_dialog.dart';
import 'package:duochat/screens/discusion/discussion.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        backgroundColor: ColorManager.white,
        elevation: 20,
        selectedFontSize: 1.4 * SizeConfig.blockSizeVertical!,
        unselectedFontSize: 1.2 * SizeConfig.blockSizeVertical!,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User 2',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return DiscussionNameDialogs(index: _currentIndex);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        title: Text(
          'Duo Chats',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Discussion(id: _currentIndex),
    );
  }
}
