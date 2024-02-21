import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/ui_builder.dart';
import 'package:kiit_connect/user/member/work/projects.dart';

class RecommendationsAndTestimonials extends StatelessWidget {
  const RecommendationsAndTestimonials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Recommender's Name")
        .addTextField("Relationship")
        .addTextField("Testimonial Text", maxLines: 3)
        .build("Recommendations", (c) => PersonalProject());
  }
}
