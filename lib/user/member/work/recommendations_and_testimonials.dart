import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/utils/builder/ui_builder.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

class RecommendationsAndTestimonials extends StatelessWidget {
  const RecommendationsAndTestimonials({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Recommender's Name")
        .addTextField("Relationship")
        .addTextField("Email")
        .addTextField("Testimonial Text", maxLines: 3)
        .build("Recommendations", (c) => const PersonalProject());
  }
}
