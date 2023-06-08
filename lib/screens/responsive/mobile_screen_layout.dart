import 'package:flutter/material.dart';
import 'package:nutrijourney/screens/blog_screen.dart';
import 'package:nutrijourney/screens/community_screen.dart';
import 'package:nutrijourney/screens/dashboard_screen.dart';
import 'package:nutrijourney/screens/planner_screen.dart';
import 'package:nutrijourney/screens/recipe_screen.dart';
import 'package:nutrijourney/utils/constants.dart';
import 'package:nutrijourney/widgets/drawer.dart';


class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> pages = [
    const DashboardScreen(),
    // const PlannerScreen(),
    const BlogScreen(),
    const RecipeScreen(),
    const CommunityScreen()
    // ProfileScreen(uid: sharedPreferences!.getString("uid")!),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Nutri Journey!', style: TextStyle(color: kPrimaryGreen),),
        iconTheme: IconThemeData(color: kPrimaryGreen),
      ),
      // extendBodyBehindAppBar: true,
      endDrawer: MyDrawer(),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _page,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: kPrimaryGreen,
        unselectedItemColor: kGrey,
        iconSize: 24,
        onTap: updatePage,
        items: [
          _buildBottomNavigationBarItem(0, Icons.dashboard, 'Dashboard'),
          _buildBottomNavigationBarItem(1, Icons.calendar_today, 'Blog'),
          _buildBottomNavigationBarItem(2, Icons.restaurant_menu, 'Recipe'),
          _buildBottomNavigationBarItem(3, Icons.people, 'Community'),
        ],
      ),
    );
  }

  // reusable widget for Bottom Navbar Item
  BottomNavigationBarItem _buildBottomNavigationBarItem(
      int pageNumber, IconData icon, String label) {
    return BottomNavigationBarItem(
        icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
                // border: Border(
                //     top: BorderSide(
                //       color: _page == pageNumber
                //           ? kPrimaryGreen
                //           : kSecondaryColor,
                //       width: bottomBarBorderWidth,
                //     )),
                ),
            child: Icon(icon)),
        label: label);
  }
}
