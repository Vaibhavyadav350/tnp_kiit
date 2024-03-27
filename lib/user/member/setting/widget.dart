import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timelines/timelines.dart'; // Import Firestore package
import 'package:firebase_auth/firebase_auth.dart';
class PackageDeliveryTrackingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Container(
            width: 360.0,
            child: Card(
              margin: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Profiling Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(height: 1.0),
                  _DeliveryProcesses(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





class _DeliveryProcesses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        color: Color(0xff9b9b9b),
        fontSize: 12.5,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StreamBuilder<DocumentSnapshot>(
          // Use a stream builder to listen to changes in Firestore data
          stream: FirebaseFirestore.instance.collection('StudentInfo').doc(FirebaseAuth.instance.currentUser?.uid).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                final Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;
                List<Map<String, dynamic>> completedItems = [];
                List<Map<String, dynamic>> notCompletedItems = [];

                if (data != null) {
                  data.forEach((process, value) {
                    bool completed = value['completed'];
                    if (completed) {
                      completedItems.add({process: value});
                    } else {
                      notCompletedItems.add({process: value});
                    }
                  });
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTimeline(completedItems),
                    SizedBox(height: 20.0),
                    _buildTimeline(notCompletedItems),
                  ],
                );
            }
          },
        ),
      ),
    );
  }

  Widget _buildTimeline(List<Map<String, dynamic>> items) {
    return FixedTimeline.tileBuilder(
      theme: TimelineThemeData(
        nodePosition: 0,
        color: Color(0xff989898),
        indicatorTheme: IndicatorThemeData(
          position: 0,
          size: 20.0,
        ),
        connectorTheme: ConnectorThemeData(
          thickness: 2.5,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        connectionDirection: ConnectionDirection.before,
        itemCount: items.length,
        contentsBuilder: (_, index) {
          final process = items[index].keys.first;
          final completed = items[index][process]['completed'];

          return Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  process,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(completed ? 'Completed' : 'Not Completed'),
                ),
              ],
            ),
          );
        },
        indicatorBuilder: (_, index) {
          final completed = items[index][items[index].keys.first]['completed'];

          return completed
              ? DotIndicator(
            color: Color(0xff66c97f),
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 12.0,
            ),
          )
              : OutlinedDotIndicator(
            borderWidth: 2.5,
          );
        },
        connectorBuilder: (_, index, ___) {
          final completed = items[index][items[index].keys.first]['completed'];

          return completed
              ? SolidLineConnector(
            color: Color(0xff66c97f), // Green connector color for completed items
          )
              : null; // Null for incomplete items
        },
      ),
    );
  }
}
