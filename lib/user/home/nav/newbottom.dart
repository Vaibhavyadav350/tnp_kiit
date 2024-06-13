import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:kiit_connect/user/home/nav/newhomescreen.dart";
import "package:kiit_connect/user/member/job/jobposting.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";
import "../Project/koncatSocial.dart";
import "../Project/projectupload.dart";
import "../usersettings/profileScreen.dart";

class MyNewBottomNavBar extends StatelessWidget {
  MyNewBottomNavBar({super.key});

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const HomeScreen(),
          item: ItemConfig(
            activeForegroundColor: Colors.green,
              icon: const Icon(FluentIcons.home_48_regular, size: 23),
              title: "Home"),
        ),
        PersistentTabConfig(
          // screen: const UploadProjectPage(),
          screen: const AddProjectFeed(),
          item: ItemConfig(
              activeForegroundColor: Colors.orange,
              icon: const Icon(FluentIcons.add_48_regular, size: 23),
              title: "Project"),
        ),
        PersistentTabConfig(
          // screen: const SocialFeed(),
          screen: const KoncatSocial(),
          item: ItemConfig(
              activeForegroundColor: Colors.redAccent,
              icon: const Icon(FluentIcons.chat_multiple_16_regular, size: 23),
              title: "Feed"),
        ),
        PersistentTabConfig(
          screen: const JobPostingFetch(),
          item: ItemConfig(
              activeForegroundColor: Colors.teal,
              icon:
                  const Icon(FluentIcons.laptop_briefcase_32_regular, size: 25),
              title: "Internship"),
        ),
        PersistentTabConfig(
          screen: ProfileScreen(),
          item: ItemConfig(
              activeForegroundColor: Colors.purple,
              icon: const Icon(FluentIcons.person_48_regular, size: 23),
              title: "Profile"),
        ),
      ];
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) => PersistentTabView(
        controller: _controller,
        tabs: _tabs(),
        navBarBuilder: (navBarConfig) => Style2BottomNavBar(
          itemAnimationProperties: ItemAnimation(
            duration: Duration(milliseconds: 900),
            curve: Curves.easeOutExpo,
          ),
          navBarConfig: navBarConfig,
        ),
      );
}
