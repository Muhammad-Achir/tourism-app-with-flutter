import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/main/index_nav_provider.dart';
import 'package:tourism_app/screen/bookmark/bookmark_screen.dart';
import 'package:tourism_app/screen/home/home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  // int _indexBottomNavBar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _indexBottomNavBar,
        currentIndex: context.watch<IndexNavProvider>().indexBottoNavBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmarks),
            label: 'Bookmarks',
            tooltip: 'Bookmarks',
          ),
        ],
        onTap: (index) {
          // setState(() {
          //   _indexBottomNavBar = index;
          // });
          context.read<IndexNavProvider>().setIndexBottomNavBar = index;
        },
      ),
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottoNavBar) {
            0 => const HomeScreen(),
            _ => const BookmarkScreen(),
          };
        }
      ),
    );
  }
}
