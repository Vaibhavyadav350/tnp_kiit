import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:inkblob_navigation_bar/inkblob_navigation_bar.dart';
import 'package:kiit_connect/theme/colors.dart';
import '../user/member/job/jobposting.dart';
import '../user/member/work/college_experience.dart';
import '../user/member/work/profesionalexp.dart';
import '../user/screens/RevampedHomePage.dart';


class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({Key? key}) : super(key: key);

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  late PageController _pageController;
  bool _animatingPage = false;
  int _selectedIndex = 2;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _animatingPage = true;
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
      _pageController
          .animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      )
          .then((value) {
        _animatingPage = false;
        _previousIndex = _selectedIndex;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            if (!_animatingPage) {
              setState(() {
                _previousIndex = _selectedIndex;
                _selectedIndex = index;
              });
            }
          },
          children: <Widget>[
            ProfessionalExperience(),
            CollegeExperience(),
            RevampedHome(),
            JobPostingFetch(),
            ProfessionalExperience(),
          ],
        ),
      ),
      bottomNavigationBar: InkblobNavigationBar(
        backgroundColor: darkHighlight,
        selectedIndex: _selectedIndex,
        previousIndex: _previousIndex,
        onItemSelected: _onItemTapped,
        curve: Curves.bounceOut,
        animationDuration: const Duration(milliseconds: 500),
        items: <InkblobBarItem>[
          InkblobBarItem(
            filledIcon: Icon(FluentIcons.camera_16_filled,size: 28),
            emptyIcon: Icon(FluentIcons.add_12_regular),
            color: Colors.blue
          ),
          InkblobBarItem(
            filledIcon: const Icon(FluentIcons.chat_multiple_16_filled,size: 28),
            emptyIcon: const Icon(FluentIcons.chat_multiple_16_regular),
            color: Colors.red,
          ),
          InkblobBarItem(
            filledIcon: const Icon(FluentIcons.person_12_filled,size: 28),
            emptyIcon: const Icon(FluentIcons.person_12_regular),
            color: Colors.purple
          ),

          InkblobBarItem(
            filledIcon: const Icon(FluentIcons.briefcase_12_filled,size: 28),
            emptyIcon: const Icon(FluentIcons.briefcase_12_regular),

            color: Colors.red,
          ),
          InkblobBarItem(
            filledIcon: const Icon(FluentIcons.settings_16_regular,size: 28),
            emptyIcon: const Icon(FluentIcons.settings_16_regular),
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}