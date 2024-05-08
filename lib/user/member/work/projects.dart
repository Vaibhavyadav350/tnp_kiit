import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/member/skill/publiclinks.dart';
import 'package:kiit_connect/user/member/work/participation_in_researches.dart';

var domainsSkill = [
  // Programming Languages
  'JavaScript',
  'Python',
  'Java',
  'C#',
  'C++',
  'Swift',
  'Kotlin',
  'Ruby',
  'PHP',
  'TypeScript',

  // Frameworks/Libraries
  'React.js',
  'Angular',
  'Vue.js',
  'Node.js',
  'Express.js',
  'Django',
  'Flask',
  'Spring Boot',
  '.NET Core',

  // Databases
  'SQL',
  'NoSQL',
  'ORM',

  // Tools
  'Git & GitHub',
  'Docker',
  'Kubernetes',
  'Jenkins',
  'Webpack',
  'Babel',

  // Web Technologies
  'HTML',
  'CSS',
  'Bootstrap',
  'SASS/SCSS',
  'GraphQL',
  'REST APIs',

  // Mobile Development
  'iOS Development',
  'Android Development',
  'React Native',
  'Flutter',

  // Cloud Services
  'Amazon Web Services',
  'Google Cloud Platform',
  'Microsoft Azure',
  'Firebase',

  // DevOps & Continuous Integration/Continuous Deployment (CI/CD)
  'DevOps',
  'Continuous Integration',
  'Continuous Deployment',

  // Testing
  'Unit Testing',
  'Integration Testing',
  'End-to-End Testing',
  'Jest',
  'Mocha',
  'JUnit',
];

const projectComplexityLevel = [
  'Basic',
  'Intermediate',
  'Advanced',
];

class PersonalProject extends StatefulWidget {
  const PersonalProject({super.key});

  @override
  State<PersonalProject> createState() => PersonalProjectState();
}

class PersonalProjectState extends State<PersonalProject> {
  String gh_user_id = "";

  @override
  void initState() {
    fetchFromFirestore();
  }

  Future<void> fetchFromFirestore() async {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    try {
      // Check if public profile has been filled up, and if done so, get github user name
      var data = docSnap.get(PUBLIC_PROFILE_KEY) as List<dynamic>;
      gh_user_id = data[0]['GithubLink']
          .replaceAll(RegExp("^.*github.com/"), "")
          .replaceAll(RegExp("[/\\\\]"), "");
    } on StateError catch (e) {
      // Ask user to go fill public profile first
      print(e);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (c) => PublicProfile()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Incomplete!!',
            message: 'Add your GitHub Link first!!',
            contentType: ContentType.failure,
          ),
          backgroundColor: Colors.transparent, // Set your desired color
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Project Name", icon: FluentIcons.icons_20_filled)
        .addTextField("From Date",hintText: "dd/mm/yy",icon:FluentIcons.calendar_edit_32_regular)
        .addTextField("To Date",hintText: "dd/mm/yy",icon:FluentIcons.calendar_edit_32_filled)
        .addComboBox("Level", projectComplexityLevel)
        .addMultiSelectComboBox("Select Skills", domainsSkill)
        // .addTextField("Git Repository Link")
        .addGitHubRepoInput("Github", restrictGHUID: (s) => s==gh_user_id)
        // .addTextField("Description", maxLines: 3)
        .addTextField("Demo Link",icon: FluentIcons.video_48_regular)
        .build("Personal Projects", (c) => const AcademicAchievements());
  }
}
