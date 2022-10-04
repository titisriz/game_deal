import 'package:flutter/material.dart';
import 'package:game_deal/deals/deal_browser/presentation/deal_browser_page.dart';
import 'package:game_deal/deals/deal_main/presentation/deal_main_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const List<Widget> pages = [
    DealMainPage(),
    DealBrowserPage(),
    // WishListPage(),
  ];

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          enableFeedback: true,
          selectedIconTheme: const IconThemeData(size: 30),
          items: const [
            BottomNavigationBarItem(icon: Icon(MdiIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(MdiIcons.web), label: 'Browse'),
            // BottomNavigationBarItem(
            //     icon: Icon(MdiIcons.heart), label: 'Wish List'),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: IndexedStack(
        children: MainPage.pages,
        index: _selectedIndex,
      ),
    );
  }
}
