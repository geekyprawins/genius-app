import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genius/favourites/view/favourites_screen.dart';
import 'package:genius/recents/view/recents_screen.dart';
import 'package:genius/search/view/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: const <Widget>[
            SearchPage(),
            RecentsScreen(),
            FavouritesScreen(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController!.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            title: const Text('Search'),
            icon: const Icon(Icons.search),
          ),
          BottomNavyBarItem(
            title: const Text('Recent'),
            icon: const Icon(Icons.history),
          ),
          BottomNavyBarItem(
            title: const Text('Favourites'),
            icon: const Icon(
              FontAwesomeIcons.heart,
            ),
          ),
        ],
      ),
    );
  }
}
