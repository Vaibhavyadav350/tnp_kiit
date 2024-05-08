import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/member/sem/majorproject.dart';
import 'package:kiit_connect/user/member/sem/minorproject.dart';
import 'package:kiit_connect/user/member/sem/semester.dart';
import 'package:kiit_connect/user/member/skill/competency.dart';
import 'package:kiit_connect/user/member/skill/extcourses.dart';
import 'package:kiit_connect/user/member/skill/publiclinks.dart';
import 'package:kiit_connect/user/member/work/college_experience.dart';
import 'package:kiit_connect/user/member/work/language_proficiency.dart';
import 'package:kiit_connect/user/member/work/open_source_contributions.dart';
import 'package:kiit_connect/user/member/work/participation_in_researches.dart';
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import 'package:kiit_connect/user/member/work/projects.dart';
import 'package:kiit_connect/user/member/work/recommendations_and_testimonials.dart';
import 'package:kiit_connect/user/member/work/startups.dart';
import 'package:kiit_connect/user/onboard/wrapper.dart';

final bool __AddRandomStudents = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } on PlatformException {
    print(
        "WARNING: Firebase not connected. If you are testing, ignore this message.");
  }

  if (__AddRandomStudents) {
    randomizeFormContent=true;
    var nullContext = StatelessElement(Placeholder());
    var targetForms = [
      SemesterReport(1, (_) => Placeholder()),
      SemesterReport(2, (_) => Placeholder()),
      SemesterReport(3, (_) => Placeholder()),
      SemesterReport(4, (_) => Placeholder()),
      SemesterReport(5, (_) => Placeholder()),
      SemesterReport(6, (_) => Placeholder()),
      SemesterReport(7, (_) => Placeholder()),
      SemesterReport(8, (_) => Placeholder()),
      MajorProject(),
      MinorProject((_) => Placeholder()),
      Competency(),
      ExtraCertifications(),
      PublicProfile(),
      CollegeExperience(),
      LanguageProficiency(),
      OpenSourceContributions(),
      AcademicAchievements(),
      ProfessionalExperience(),
      /*PersonalProject(),*/
      // PersonalProjectState(),
      RecommendationsAndTestimonials(),
      StartupInformation()
    ];
    for (int i = 0; i < 100; i++) {
    final Map<String, dynamic> data = {
      'name': 'Fake Chan ${Ransom.integer()}',
      'roll': Ransom.integerString(),
      'year': Ransom.integerString(),
      'phone': Ransom.integerString(),
      'email': Ransom.string(),
      'address': Ransom.string(),
      'photoUrl': Ransom.string(),
    };
    print("object");
    for (var value in targetForms) {
      var talika = value.build(nullContext) as Talika;
      var state = StatefulElement(talika).state as TalikaState;
      state.initState();
      data[talika.firebaseKey] =state.forms.map((e) => state.widget.stencil.serialize(e)).toList();
    }
    print(data);
    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc()
        .set(data);
    }
  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ColorProfile.instance =
        ColorProfile.dark(const Color.fromARGB(255, 62, 108, 154));
    final ThemeData theme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: greenHighlight,
        background: ColorProfile().background,
        primary: Colors.white70,
        primaryContainer: ColorProfile().background,
        secondary: Colors.white70,
        secondaryContainer: darkHighlight,
        tertiary: greenHighlight,
      ),
      cardColor: greenHighlight,
      useMaterial3: true,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'T&P KIIT',
      theme: theme,
      darkTheme: theme.copyWith(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      home: const Wrapper(),
    );
  }
}
