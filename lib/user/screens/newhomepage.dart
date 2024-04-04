// import 'package:flutter/material.dart';
// import 'package:kiit_connect/user/member/basicprofile.dart';
//
// import 'package:flutter/material.dart';
// import 'package:kiit_connect/theme/colors.dart';
// import 'package:kiit_connect/user/member/school/tenth_ac.dart';
// import 'package:kiit_connect/user/member/school/tenth_achievements.dart';
// import 'package:kiit_connect/user/member/school/twelfth_achievements.dart';
// import 'package:kiit_connect/user/member/school/twelth_ac.dart';
// import 'package:kiit_connect/user/member/sem/eighth_sem.dart';
// import 'package:kiit_connect/user/member/sem/fifth_sem.dart';
// import 'package:kiit_connect/user/member/sem/first_sem.dart';
// import 'package:kiit_connect/user/member/sem/fourth_sem.dart';
// import 'package:kiit_connect/user/member/sem/second_sem.dart';
// import 'package:kiit_connect/user/member/sem/seventh_sem.dart';
// import 'package:kiit_connect/user/member/sem/sixth_sem.dart';
// import 'package:kiit_connect/user/member/sem/third_sem.dart';
// import 'package:kiit_connect/user/member/skill/competency.dart';
// import 'package:kiit_connect/user/member/skill/extcourses.dart';
// import 'package:kiit_connect/user/member/skill/publiclinks.dart';
// import 'package:kiit_connect/user/member/work/college_experience.dart';
// import 'package:kiit_connect/user/member/work/participation_in_researches.dart';
// import 'package:kiit_connect/user/member/work/profesionalexp.dart';
// import 'package:kiit_connect/user/member/work/projects.dart';
// import 'package:kiit_connect/user/member/work/startups.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import '../../theme/utils/ThemeBackgrounds.dart';
// import '../../theme/utils/cards.dart';
// import '../member/basicprofile.dart';
// import '../../theme/colors.dart';
// import '../../theme/vycontainers.dart';
//
// class RevampedHome extends StatefulWidget {
//   @override
//   State<RevampedHome> createState() => _RevampedHomeState();
// }
//
// class _RevampedHomeState extends State<RevampedHome> {
//   var height, width;
//
//   @override
//   Widget build(BuildContext context) {
//     var profile = ColorProfile();
//     height = MediaQuery.of(context).size.height;
//     width = MediaQuery.of(context).size.width;
//
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                 child: Text(
//                   "Preliminaries",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => BasicProfile()),
//                         );
//                       },
//                       child: VaibhavContainerBig(
//                         height: height / 4.5,
//                         width: width * 0.8,
//                         title: "Basic Profile",
//                         description: "Update your profile",
//                         image: AssetImage("aassets/images/profile-edit.png"),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap:(){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Competency()),
//                         );
//                       },
//                       child: VaibhavContainerBig(
//                         height: height / 4.5,
//                         width: width * 0.8,
//                         title: "Skills",
//                         description: "Learn from industry experts!",
//                         image: AssetImage("assets/images/backgrounds/08_programming_skills_background.png"),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap:(){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => PublicProfile()),
//                         );
//                       },
//                       child: VaibhavContainerBig(
//                         height: height / 4.55,
//                         width: width * 0.8,
//                         title: "Public Links",
//                         description: "Enter you github, Linkedin Links",
//                         image: AssetImage("assets/images/ai.png"),
//                       ),
//                     ),
//                     // Add more VaibhavContainers here as needed
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                 child: Text(
//                   "College",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.vertical,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap :()
//                         {
//                           showModalBottomSheet(
//                             backgroundColor: darkHighlight,
//                             context: context,
//                             builder: (context) {
//                               return Wrap(
//                                 children: [
//                                   ListTile(
//                                     leading: Icon(
//                                       Icons.article_outlined,
//                                       color: primary,
//                                     ),
//                                     title: Text(
//                                       'Semester 1',
//                                       style: TextStyle(color: primary),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               FirstSemesterPerformance(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   ListTile(
//                                     leading: Icon(
//                                       Icons.article_outlined,
//                                       color: primary,
//                                     ),
//                                     title: Text(
//                                       'Semester 2',
//                                       style: TextStyle(color: primary),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               SecondSemesterPerformance(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   ListTile(
//                                     leading: Icon(
//                                       Icons.article_outlined,
//                                       color: primary,
//                                     ),
//                                     title: Text(
//                                       'Semester 3',
//                                       style: TextStyle(color: primary),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               ThirdSemesterPerformance(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   ListTile(
//                                     leading: Icon(
//                                       Icons.article_outlined,
//                                       color: primary,
//                                     ),
//                                     title: Text(
//                                       'Semester 4',
//                                       style: TextStyle(color: primary),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               FourthSemesterPerformance(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   ListTile(
//                                     leading: Icon(
//                                       Icons.article_outlined,
//                                       color: primary,
//                                     ),
//                                     title: Text(
//                                       'Semester 5',
//                                       style: TextStyle(color: primary),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               FifthSemesterPerformance(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   ListTile(
//                                     leading: Icon(
//                                       Icons.article_outlined,
//                                       color: primary,
//                                     ),
//                                     title: Text(
//                                       'Semester 6',
//                                       style: TextStyle(color: primary),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               SixthSemesterPerformance(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   ListTile(
//                                     leading: Icon(
//                                       Icons.article_outlined,
//                                       color: primary,
//                                     ),
//                                     title: Text(
//                                       'Semester 7',
//                                       style: TextStyle(color: primary),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               SeventhSemesterPerformance(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   ListTile(
//                                     leading: Icon(
//                                       Icons.article_outlined,
//                                       color: primary,
//                                     ),
//                                     title: Text(
//                                       'Semester 8',
//                                       style: TextStyle(color: primary),
//                                     ),
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) =>
//                                               EightSemesterPerformance(),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//
//                       },
//                       child: VaibhavContainerBig(
//                         height: height / 5,
//                         width: width * 0.96,
//                         title: "SemsterWise Report",
//                         description: "Showcase your coding skills!",
//                         image: AssetImage("assets/images/competi.png"),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap:(){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => CollegeExperience()),
//                         );
//                       },
//                       child: VaibhavContainerBig(
//                         height: height / 5,
//                         width: width * 0.96,
//                         title: "College Experience",
//                         description: "Listen to our latest tech discussions!",
//                         image: AssetImage("assets/images/podcast.png"),
//                       ),
//                     ),
//                     // VaibhavContainerBig(
//                     //   height: height / 5,
//                     //   width: width * 0.96,
//                     //   title: "Code Challenge",
//                     //   description: "Test your coding abilities!",
//                     //   image: AssetImage("assets/images/codecha.png"),
//                     // ),
//
//                     // Add more VaibhavContainers here as needed
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                 child: Text(
//                   "Extra Academics",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => PersonalProject()),
//                         );
//                       },
//                       child: VaibhavContainerSmall(
//                         height: height / 4.8,
//                         width: width * 0.4,
//                         title: "Projects",
//                         image: AssetImage("assets/images/app.png"),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => AcademicAchievements()),
//                         );
//                       },
//                       child: VaibhavContainerSmall(
//                         height: height / 4.8,
//                         width: width * 0.4,
//                         title: "Publications",
//                         image: AssetImage("assets/images/web.png"),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => ProfessionalExperience()),
//                         );
//                       },
//                       child: VaibhavContainerSmall(
//                         height: height / 4.8,
//                         width: width * 0.4,
//                         title: "Internships",
//                         image: AssetImage("assets/images/blockchain.png"),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => StartupInformation()),
//                         );
//                       },
//                       child: VaibhavContainerSmall(
//                         height: height / 4.8,
//                         width: width * 0.4,
//                         title: "Startups",
//                         image: AssetImage("assets/images/aiml.png"),
//                       ),
//                     ),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(builder: (context) => UiUxPage()),
//                     //     );
//                     //   },
//                     //   child: VaibhavContainerSmall(
//                     //     height: height / 4.8,
//                     //     width: width * 0.4,
//                     //     title: "UI/UX",
//                     //     image: AssetImage("assets/images/uiux.png"),
//                     //   ),
//                     // ),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(builder: (context) => CoreDevPage()),
//                     //     );
//                     //   },
//                     //   child: VaibhavContainerSmall(
//                     //     height: height / 4.8,
//                     //     width: width * 0.4,
//                     //     title: "CoreDev",
//                     //     image: AssetImage("assets/images/core.png"),
//                     //   ),
//                     // ),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(builder: (context) => GameDevPage()),
//                     //     );
//                     //   },
//                     //   child: VaibhavContainerSmall(
//                     //     height: height / 4.8,
//                     //     width: width * 0.4,
//                     //     title: "Game Dev",
//                     //     image: AssetImage("assets/images/game.png"),
//                     //   ),
//                     // ),
//                     // Add more GestureDetector wrapped VaibhavContainerSmall widgets here as needed
//                   ],
//                 ),
//               ),
//
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
//                 child: Text(
//                   "Schooling",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     GestureDetector(
//                       onTap:(){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => TenthGradeInfo()),
//                         );
//                       },
//                       child: VaibhavContainerSmall(
//                         height: height / 4.8,
//                         width: width * 0.8,
//                         title: "10th Academics",
//                         image: AssetImage("assets/images/network.png"),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap:(){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => TwelfthGradeInfo()),
//                         );
//                       },
//                       child: VaibhavContainerSmall(
//                         height: height / 4.8,
//                         width: width * 0.8,
//                         title: "12th Academics",
//                         image: AssetImage("assets/images/guest.png"),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap:(){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => TenthGradeAchievements()),
//                         );
//                       },
//                       child: VaibhavContainerSmall(
//                         height: height / 4.8,
//                         width: width * 0.8,
//                         title: "Achievements upto 10th",
//                         image: AssetImage("assets/images/blockchain.png"),
//                       ),
//                     ), GestureDetector(
//                       onTap:(){
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => TwelfthGradeAchievements()),
//                         );
//                       },
//                       child: VaibhavContainerSmall(
//                         height: height / 4.8,
//                         width: width * 0.8,
//                         title: "Achievements upto 12th",
//                         image: AssetImage("assets/images/blockchain.png"),
//                       ),
//                     ),
//                     // Add more VaibhavContainers here as needed
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
