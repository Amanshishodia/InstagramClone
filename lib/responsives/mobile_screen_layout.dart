import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta/utils/colors.dart';
import 'package:insta/utils/globarVariables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    pageController.dispose();
  }

  void navigationTap(int page) {
    pageController.jumpToPage(page);
  }
  void  onPagechanged(int page){
    setState(() {
      _page=page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: PageView(
          children: homeScreenItems,
          controller: pageController,
          onPageChanged:onPagechanged ,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: _page == 1 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle,
                color: _page == 2 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _page == 4 ? primaryColor : secondaryColor,
              ),
              label: '',
              backgroundColor: primaryColor)
        ],
        onTap: navigationTap,
      ),
    );
  }
}
