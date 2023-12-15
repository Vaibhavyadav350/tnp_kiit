import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllStudentsPage extends StatefulWidget {
  @override
  _AllStudentsPageState createState() => _AllStudentsPageState();
}

class _AllStudentsPageState extends State<AllStudentsPage> {
  List<DocumentSnapshot> allStudents = [];
  List<DocumentSnapshot> displayedStudents = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllStudents();
  }

  void _getAllStudents() async {
    var querySnapshot = await FirebaseFirestore.instance.collection('StudentInfo').get();
    setState(() {
      allStudents = querySnapshot.docs;
      displayedStudents = allStudents;
    });
  }

  void _filterStudents(String query) {
    setState(() {
      displayedStudents = allStudents.where((student) {
        var studentData = student.data() as Map<String, dynamic>;

        // Check skills in ProfessionalExperiences
        var professionalExperiences = studentData['ProfessionalExperiences'] != null
            ? (studentData['ProfessionalExperiences'] as List<dynamic>)
            .map((exp) => (exp['Skills'] as List<dynamic>).join(', '))
            .toList()
            : [];

        // Check skills in PersonalProjects
        var personalProjects = studentData['PersonalProjects'] != null
            ? (studentData['PersonalProjects'] as List<dynamic>)
            .map((project) => (project['Skills'] as List<dynamic>).join(', '))
            .toList()
            : [];

        return professionalExperiences.any((skills) => skills.toLowerCase().contains(query.toLowerCase())) ||
            personalProjects.any((skills) => skills.toLowerCase().contains(query.toLowerCase()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Students'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: _filterStudents,
              decoration: InputDecoration(
                labelText: 'Search Students',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _buildStudentList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList() {
    if (displayedStudents.isEmpty) {
      return Center(
        child: Text('No students found.'),
      );
    }

    return ListView.builder(
      itemCount: displayedStudents.length,
      itemBuilder: (context, index) {
        var studentData = displayedStudents[index].data() as Map<String, dynamic>;

        var professionalExperiences = studentData['ProfessionalExperiences'] != null
            ? (studentData['ProfessionalExperiences'] as List<dynamic>)
            .map((exp) => {
          'Skills': (exp['Skills'] as List<dynamic>).join(', '),
          'Company': exp['Company'],
        })
            .toList()
            : [];
        // Rest of your ListTile and container code...
        var personalProjects = studentData['PersonalProjects'] != null
            ? (studentData['PersonalProjects'] as List<dynamic>)
            .map((project) => {
          'Skills': (project['Skills'] as List<dynamic>).join(', '),
          'Project Name': project['Project Name'],
        })
            .toList()
            : [];
        return Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            title: Text(studentData['name']),
            subtitle:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Professional Experiences:'),
                ...professionalExperiences
                    .map(
                      (exp) => Container(
                    color: Colors.white,
                    child: Text(
                      'Skills: ${exp['Skills']}, Company: ${exp['Company']}',
                      style: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                )
                    .toList(),
                Text('Personal Projects:'),
                ...personalProjects
                    .map(
                      (project) => Container(
                    color: Colors.white,
                    child: Text(
                      'Skills: ${project['Skills']}, Project Name: ${project['Project Name']}',
                      style: TextStyle(
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                )
                    .toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
