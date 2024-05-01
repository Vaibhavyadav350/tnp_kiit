import 'package:flutter/cupertino.dart';

import '../theme/utils/builder/ui_builder.dart';
import '../user/home/HomePage.dart';

class Query extends StatelessWidget {
  const Query({super.key});

  @override
  Widget build(BuildContext context) {
    return FormBuilder()
        .addTextField("Subject")
        .addTextField("Query",maxLines: 3)
        .build("Student Query",(c) => const HomePage());
  }
}
