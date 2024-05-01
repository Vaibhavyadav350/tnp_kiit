import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
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

class PersonalProject extends StatelessWidget {
  const PersonalProject({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()

        .addTextField("Project Name",icon: FluentIcons.icons_20_filled)
        .addComboBox("Level", projectComplexityLevel)
        .addMultiSelectComboBox("Select Skills", domainsSkill)
        // .addTextField("Git Repository Link")
        .addGitHubRepoInput("Github")
        // .addTextField("Description", maxLines: 3)
        .addTextField("Demo Link")
        .build("Personal Projects", (c) => const AcademicAchievements());
  }
}
