import 'package:flutter/material.dart';

class MultiSelectDropdownScreen extends StatefulWidget {
  @override
  _MultiSelectDropdownScreenState createState() =>
      _MultiSelectDropdownScreenState();
}

class _MultiSelectDropdownScreenState extends State<MultiSelectDropdownScreen> {
  var doamisSkills = [
    'JavaScript',
    'Python',
    'Java',
    // ... Add other skills ...
  ];

  List<String> _selectedSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multi Select Dropdown')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                items: doamisSkills.map<DropdownMenuItem<String>>((String skill) {
                  return DropdownMenuItem<String>(
                    value: skill,
                    child: CheckboxListTile(
                      title: Text(skill),
                      value: _selectedSkills.contains(skill),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedSkills.add(skill);
                          } else {
                            _selectedSkills.remove(skill);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
                onChanged: (_) {}, // Not needed here
                hint: Text('Select your skills'),
              ),
            ),
            SizedBox(height: 20),
            Text('Selected Skills: ${_selectedSkills.join(', ')}'),
          ],
        ),
      ),
    );
  }
}
