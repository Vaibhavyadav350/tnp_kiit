import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/user/member/chat/vybutton_.dart';
import 'package:timelines/timelines.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TimelineScreen extends StatefulWidget {
  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

bool valid = false;

class _TimelineScreenState extends State<TimelineScreen> {
  Future<DocumentSnapshot<Map<String, dynamic>>> _fetchTimelineData() async {
    // Replace 'your_collection' with the actual collection name in your Firestore
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
        appBar: AppBar(
          backgroundColor: darkShadow,
          title: Text(
            "   Filled Data",
            style: TextStyle(color: Colors.white),
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info))],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
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
                      // Parse data from Firestore
                      final data = snapshot.data?.data();
                      if (data == null || data.isEmpty) {
                        return Center(
                          child: Text('No data available'),
                        );
                      }

                      // Get all array names inside the document
                      final arrayNames = data.keys
                          .where((key) => data[key] is List || data[key] is Map)
                          .toList();

                      return FixedTimeline.tileBuilder(
                        theme: TimelineThemeData(
                          nodePosition: 0,
                          color: Colors.lightGreenAccent,
                          // Light green color for timeline
                          indicatorTheme: IndicatorThemeData(
                            size: 20.0,
                            position: 0.0,
                            color: Colors
                                .lightGreenAccent, // Light green color for timeline indicators
                          ),
                          connectorTheme: ConnectorThemeData(
                            thickness: 2.5,
                            color: Colors
                                .lightGreenAccent, // Light green color for connectors
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
                                // You can add onTap functionality if needed
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                if (valid)
                  VyButton("Data Sent for Validation!", Icons.upcoming, () {}),
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
                            .collection('StudentInfo')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .collection('validdata')
                            .doc(FirebaseAuth.instance.currentUser?.uid)
                            .set(userData.data() ?? {});

                        // Show a success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Data sent for validation successfully!'),
                          ),
                        );
                      } catch (error) {
                        // Show an error message if something goes wrong
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: $error'),
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
      ),
    );
  }
}
