import 'package:eurovisionvoteapp/Languages/en_lang.dart';
import 'package:flutter/material.dart';
import '../../../themes/darkTheme.dart';
import '../../../utils/constants.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _page = 0;
  late PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      /*appBar: AppBar(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50))),
        title: Text(
          '2022',
          style: TextStyle(fontSize: 32, color: Colors.black),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  print("Arrow down pressed");
                },
                child: const Icon(Icons.arrow_drop_down_outlined,
                    color: Colors.black),
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),*/
      body: PageView(
        children: Constants.navigationItems,
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ), //GroupBoxes(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.black,
        selectedItemColor: whiteColor,
        unselectedItemColor: Colors.white54,
        currentIndex: _page,
        onTap: navigationTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: LangEn.bottomNavBarLables[0],
            backgroundColor:
                _page == 1 ? Constants.navBarColor : Constants.kBlackColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.people_rounded),
            label: LangEn.bottomNavBarLables[1],
            backgroundColor:
                _page == 2 ? Constants.navBarColor : Constants.kBlackColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.mic_external_on),
            label: LangEn.bottomNavBarLables[2],
            backgroundColor:
                _page == 3 ? Constants.navBarColor : Constants.kBlackColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite),
            label: LangEn.bottomNavBarLables[3],
            backgroundColor:
                _page == 4 ? Constants.navBarColor : Constants.kBlackColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: LangEn.bottomNavBarLables[4],
            backgroundColor:
                _page == 5 ? Constants.navBarColor : Constants.kBlackColor,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
