import 'package:flutter/material.dart';

enum ThemedBackground {
  home("01_home_background.png"),
  collegeExperience("02_societies_background.png"),
  academicAchievements("03_research_works_background.png"),
  professionalExperience("04_internships_background.png"),
  personalProjects("05_personal_projects_background.png"),
  startupInformation("06_startups_background.png"),
  extraCertifications("07_co_curricular_background.png"),
  competency("08_programming_skills_background.png"),
  publicLinks("09_social_platforms_background.png"),
  semesterStudies("10_semester_studies_background.png"),
  tenthDetails("11_tenth_details_background.png"),
  twelfthDetails("12_twelveth_details_background.png"),
  basicProfile("13_basic_profile_background.png"),
  discoverSomethingNew("14_discover_somethig_new_background.png"),
  tenthAchievements("15_tenth_achievements_background.png"),
  twelfthAchievements("16_twelveth_achievements_background.png"),
  idk(""),
  newArticles("18_new_articles_background.png"),
  newCourses("19_new_courses_background.png"),
  projectIdeas("20_project_ideas_background.png");

  final String asset;
  final Alignment alignment;
  final double scale;

  const ThemedBackground(
    String item, {
    this.alignment = Alignment.topRight,
    this.scale = 13,
  }) : asset = "assets/images/backgrounds/$item";

  DecorationImage bigDeco({colorFilter}) {
    return DecorationImage(
        image: AssetImage(asset),
        fit: BoxFit.none,
        scale: scale,
        alignment: alignment,
        colorFilter: colorFilter);
  }

  DecorationImage smallDeco({colorFilter}) {
    return DecorationImage(
        image: AssetImage(asset),
        fit: BoxFit.none,
        scale: scale * 1.4,
        alignment: Alignment(-alignment.x, alignment.y),
        colorFilter: colorFilter);
  }
}
