import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiit_connect/navigation/drawer.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/theme/utils/button/vybutton_.dart';
import 'package:timelines/timelines.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../navigation/devdrawer.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

bool valid = false;

class _TimelineScreenState extends State<TimelineScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }
  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchTimelineData() async {
    return FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
  }

  Future<void> checkvalidStatus() async {
    String studentEmail = FirebaseAuth.instance.currentUser!.email!;
    var snapshot = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    var userData = snapshot.data();
    if (userData != null && userData['validate'] == 'Applied') {
      setState(() {
        valid = true;
      });
    } else {
      setState(() {
        valid = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkvalidStatus();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer:Notifi(),
        key: _scaffoldKey,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("     Filled Data", style: textTitle(context)),
                  SizedBox(
                    height: 60,

                    child:IconButton(
                      icon: Icon(FluentIcons.alert_48_regular ,color: Colors.white,),
                      onPressed:_openDrawer,

                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: _fetchTimelineData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      final data = snapshot.data?.data();
                      if (data == null || data.isEmpty) {
                        return Center(
                          child: Text('No data available'),
                        );
                      }
                      final arrayNames = data.keys
                          .where((key) => data[key] is List || data[key] is Map)
                          .toList();

                      return FixedTimeline.tileBuilder(
                        theme: TimelineThemeData(
                          nodePosition: 0,
                          color: Colors.green,
                          indicatorTheme: IndicatorThemeData(
                            size: 20.0,
                            position: 0.0,
                            color: Colors
                                .green,
                          ),
                          connectorTheme: ConnectorThemeData(
                            thickness: 2.5,
                            color: Colors
                                .green,
                          ),
                        ),
                        builder: TimelineTileBuilder.fromStyle(
                          indicatorStyle: IndicatorStyle.dot,
                          itemCount: arrayNames.length,
                          contentsBuilder: (context, index) {
                            final arrayName = arrayNames[index];
                            return Card(
                              color: Colors.white,
                              child: ListTile(
                                title: Text(arrayName,
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 16)),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
              // if (valid)
              //   VyButton("Data Sent for Validation!", Icons.upcoming, () {}),
              if (!valid)
                VyButton("Send Data for Validation", Icons.upcoming,
                    () async {
                  bool confirm = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Confirmation',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Text(
                          'After sending the data for validation, it cannot be modified or supplemented without TNP Dept permission.',
                          style: TextStyle(color: Colors.white)),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Confirm'),
                        ),
                      ],
                    ),
                  );

                  if (confirm != null && confirm) {
                    try {
                      // Get reference to the current user's document in 'StudentInfo' collection
                      DocumentReference<Map<String, dynamic>> userDocRef =
                          FirebaseFirestore.instance
                              .collection('StudentInfo')
                              .doc(FirebaseAuth.instance.currentUser?.uid);

                      // Get the data from the user's document
                      DocumentSnapshot<Map<String, dynamic>> userData =
                          await userDocRef.get();

                      // Save the data to a new document in the 'validdata' sub-collection
                      await FirebaseFirestore.instance
                          .collection('DataForValidation')
                          .doc(FirebaseAuth.instance.currentUser?.uid)
                          .set(userData.data() ?? {});

                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Oh Hey!!',
                            message:
                            'Data Sent for Validation',
                            contentType: ContentType.success,
                          ),
                        ),
                      );
                    } catch (error) {
                      // Show an error message if something goes wrong
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Oh No!!',
                            message:
                            'Failed to Save Data!',
                            contentType: ContentType.failure,
                          ),
                        ),
                      );
                    }

                    // Update the validation status to 'Applied'
                    await FirebaseFirestore.instance
                        .collection('StudentInfo')
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .update({'validate': 'Applied'});

                    // Update the UI
                    setState(() {
                      valid = true;
                    });
                  }
                })
            ],
          ),
        ),
      ),
    );
  }
}
