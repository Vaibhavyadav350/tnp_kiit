import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/profesionalexp.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

enum CompetencyLevel {
  Introductory,
  Beginner,
  Intermediate,
  Professional;

  static final types = CompetencyLevel.values
      .map((e) => e.toString().substring(16).keywordToSentence())
      .toList();
}

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

class Competency extends StatelessWidget {
  const Competency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addComboBox("Competency", CompetencyLevel.types)
        .addMultiSelectComboBox("Skills", domainsSkill)
        .limitMaximumInstancesTo(CompetencyLevel.types.length)
        .build("Skills", (c) => ProfessionalExperience());
  }
}
