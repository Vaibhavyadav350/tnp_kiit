import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../theme/maintenance.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Maintenance(),
    );
  }
}
