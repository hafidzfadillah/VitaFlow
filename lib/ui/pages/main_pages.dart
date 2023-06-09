import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vitaflow/ui/home/theme.dart';
import 'package:vitaflow/ui/pages/home_screen.dart';
import 'package:vitaflow/ui/pages/article_screen.dart';
import 'package:vitaflow/ui/pages/chat_bot.dart';
import 'package:vitaflow/ui/pages/vita_mart.dart';
import 'package:vitaflow/ui/pages/programScreen.dart';

class MainPages extends StatefulWidget {
  const MainPages({Key? key}) : super(key: key);

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<PersistentBottomNavBarItem> _items = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home_filled),
      title: 'Home',
      activeColorPrimary: primaryColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.sticky_note_2),
      title: 'Program',
      activeColorPrimary: primaryColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.storefront),
      title: 'VitaMart',
      activeColorPrimary: primaryColor,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.article),
      title: 'Artikel',
      activeColorPrimary: primaryColor,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  List<Widget> _screens = [
    HomeScreen(),
    ProgramScreen(),
    VitaMartScreen(),
    ArticleScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      items: _items,
      screens: _screens,
      navBarStyle:
          NavBarStyle.style3, // Choose the nav bar style with this property.
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
    );
  }
}
