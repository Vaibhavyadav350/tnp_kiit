import "package:fluentui_system_icons/fluentui_system_icons.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:kiit_connect/user/home/nav/newhomescreen.dart";
import "package:kiit_connect/user/member/job/jobposting.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";

import "../../member/chat/feed.dart";
import "../../member/chat/uploadproject.dart";
import "../../member/setting/timeline.dart";


class MyNewBottomNavBar extends StatelessWidget {
   MyNewBottomNavBar({super.key});

  List<PersistentTabConfig> _tabs() => [
    PersistentTabConfig(
      screen: const UploadProjectPage(),
      item: ItemConfig(
        icon: const Icon(FluentIcons.add_48_regular,size: 23),
          title: "Project"
      ),
    ),
    PersistentTabConfig(
      screen: const SocialFeed(),
      item: ItemConfig(
          icon: const Icon(FluentIcons.chat_multiple_16_regular,size: 23),
          title: "Feed"

      ),
    ),
    PersistentTabConfig(
      screen: const HomeScreen(),
      item: ItemConfig(
          icon: const Icon(FluentIcons.home_48_regular,size: 23),
          title: "Home"
      ),
    ),
    PersistentTabConfig(
      screen: const JobPostingFetch(),
      item: ItemConfig(
          icon: const Icon(FluentIcons.laptop_briefcase_32_regular,size: 25),
          title: "Internship"

      ),
    ),
    PersistentTabConfig(
      screen: TimelineScreen(),
      item: ItemConfig(
          icon: const Icon(FluentIcons.person_48_regular,size: 23),
          title: "Profile"

      ),
    ),
  ];
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) => PersistentTabView(
    controller: _controller,
    tabs: _tabs(),
    navBarBuilder: (navBarConfig) => Style2BottomNavBar(
      navBarConfig: navBarConfig,
    ),
  );
}