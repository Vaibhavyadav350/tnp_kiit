import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../drawer/drawer.dart';
import '../theme/neo_box.dart';

class EducationDetails extends StatefulWidget {
  @override
  _EducationDetailsState createState() => _EducationDetailsState();
}

class _EducationDetailsState extends State<EducationDetails> {
  final _formKey = GlobalKey<FormState>();
  final _Programcontroller = TextEditingController();
  final _branchController = TextEditingController();
  final _Backlogcontroller = TextEditingController();
  final _YearofPasscontroller = TextEditingController();
  final _CGPAcontroller = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  @override
  void initState() {
    super.initState();
    _fetchFromFirestore();
  }

  Future<void> _fetchFromFirestore() async {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    Map<String, dynamic> data = docSnap.data() as Map<String, dynamic>;
    _Programcontroller.text = data['Program'] ?? '';
    _branchController.text = data['branch'] ?? '';
    _YearofPasscontroller.text = data['YearofPassiing'] ?? '';
    _CGPAcontroller.text = data['CGPA'] ?? '';
    _Backlogcontroller.text = data['Backlog'] ?? '';
  }

  void _saveToFirestore() async {
    final tripData = {
      'Program': _Programcontroller.text,
      'branch': _branchController.text,
      'YearofPassiing': _YearofPasscontroller.text,
      'CGPA': _CGPAcontroller.text,
      'Backlog': _Backlogcontroller.text,
    };

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(tripData, SetOptions(merge: true))
        .then((documentRef) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Education Info Updated!!')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save information')),
      );
    });
    // Navigator.of(context).pushReplacement(
    //   MaterialPageRoute(builder: (context) => Collections()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: SideDrawer(),
      backgroundColor: Colors.grey[300],
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: NeoBox(
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            // Handle back button pressed
                          },
                        ),
                      ),
                    ),
                    Text(
                      "EDUCATION DETAIL",
                      style: TextStyle(letterSpacing: 2),
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: NeoBox(
                        child: IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: _openDrawer,
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 30),
                      NeoBox(
                        child: TextFormField(
                          controller: _Programcontroller,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.book),
                            labelText: 'Program',
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Program Name';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      NeoBox(
                        child: TextFormField(
                          controller: _branchController,
                          decoration: InputDecoration(
                              labelText: 'Branch',
                              prefixIcon: Icon(Icons.computer),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Branch';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      NeoBox(
                        child: TextFormField(
                          controller: _YearofPasscontroller,
                          decoration: InputDecoration(
                              labelText: 'Year of Passing',
                              prefixIcon: Icon(Icons.date_range),
                              border: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the Passing Year';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      NeoBox(
                        child: TextFormField(
                          controller: _Backlogcontroller,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.warning),
                              labelText: 'Backlog', border: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter no. of Backlog';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      NeoBox(
                        child: TextFormField(
                          controller: _CGPAcontroller,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.code),
                              labelText: 'CGPA', border: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter CGPA';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _saveToFirestore();
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Proceed'),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
