import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/theme/neo_box.dart';
import 'package:kiit_connect/user/newscreens/home.dart';

extension StringExtension on String {
  static final nonVerbalStuff = RegExp("[^\\w]+");

  String __sentenceCase() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String toFormattableKey() {
    return split(nonVerbalStuff)
        .where((e) => e.isNotEmpty)
        .map((e) => e.__sentenceCase())
        .join();
  }
}

class FormBuilder extends StatefulWidget {
  final String displayTitle;
  String firebaseName;
  Widget Function(BuildContext) nextPage;

  final List<_FormItem> formItems = [];

  FormBuilder(this.displayTitle, this.nextPage, {this.firebaseName = ""}) {
    firebaseName =
        firebaseName.isEmpty ? displayTitle.toFormattableKey() : firebaseName;
  }

  @override
  _FormBuilderState createState() => _FormBuilderState();

  FormBuilder addTextField(String label,
      {maxLines = 1, hintText = "", IconData? icon, key}) {
    final controller = TextEditingController();
    key ??= label.toFormattableKey();
    formItems.add(_FormItem(
        key,
        label,
        (state, context, theme) => MatTextField(
            label: label,
            controller: controller,
            maxLines: maxLines,
            hintText: hintText,
            icon: icon)));
    return this;
  }

  FormBuilder addComboBox(String label, List<String> validValues,
      {defaultValue = ""}) {
    final key = label.toFormattableKey();
    String value = defaultValue.isEmpty ? validValues[0] : defaultValue;
    formItems.add(_FormItem(
        key,
        displayTitle,
        (state, context, theme) => padWrap(SizedBox(
            width: double.infinity,
            child: boxWrap(
                Center(
                    child: DropdownButton<String>(
                        value: value,
                        style: textAnnotation(context),
                        icon: Icon(Icons.keyboard_arrow_down,
                            color: theme.primaryColor),
                        items: validValues.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            state.setState(() {
                              value = newValue;
                            });
                          }
                        })),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0)))),
        defaultValue: defaultValue));
    return this;
  }

  FormBuilder addMultiTextBox(String label) {
    final key = label.toFormattableKey();
    final controllers = [TextEditingController()];
    formItems.add(_FormItem(
      key,
      displayTitle,
      (state, context, theme) => padWrap(Column(children: [
        SizedBox(
            width: double.infinity,
            child: Text("Add " + label, style: textAnnotation(context))),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: boxWrap(Column(
            children: controllers
                .map((e) => TextField(
                      controller: e,
                      style: textAnnotation(context),
                    ))
                .toList(),
          )),
        ),
        SizedBox(height: 20),
        boxWrap(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () => state
                    .setState(() => controllers.add(TextEditingController())),
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
                onPressed: () => state.setState(() {
                      if (controllers.length > 1) controllers.removeLast();
                    }),
                icon: Icon(
                  Icons.remove,
                  color: Theme.of(context).primaryColor,
                )),
          ],
        ))
      ])),
      defaultValue: List<String>.from([]),
      mapToValue: (m) => List<String>.from(m[key] ?? [])
          .map((e) => TextEditingController(text: e)),
      valueToMap: (m, v) => m[key] = v.map((e) => e.value).toList(),
    ));
    return this;
  }
}

class _FormItem {
  String firebaseKey;
  String displayTitle;
  dynamic defaultValue;
  Widget Function(State<FormBuilder>, BuildContext, ThemeData) build;
  dynamic Function(Map<String, dynamic>)? mapToValue;
  void Function(Map<String, dynamic>, dynamic)? valueToMap;

  _FormItem(this.firebaseKey, this.displayTitle, this.build,
      {this.mapToValue, this.valueToMap, this.defaultValue = ""}) {
    mapToValue ??= (m) => m[firebaseKey];
    valueToMap ??= (m, v) => m[firebaseKey] = v;
  }

  dynamic getValue(Map<String, dynamic> m) => mapToValue!(m);

  dynamic setValue(Map<String, dynamic> m, dynamic v) => valueToMap!(m, v);
}

class _FormBuilderState extends State<FormBuilder> {
  final _formKey = GlobalKey<FormState>();
  List<List<dynamic>> _formsList = [];

  @override
  Widget build(BuildContext context) {
    if (_formsList.isEmpty) addForm();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            saveToFirestore();
          }
        },
        label: Text('Proceed', style: textAnnotation(context)),
        icon:
            const Icon(Icons.keyboard_double_arrow_right, color: Colors.black),
        backgroundColor: greenHighlight,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      // Handle back button pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewHomePage(),
                        ),
                      );
                    },
                  ),
                ),
                Text(widget.displayTitle, style: textTitle(context)),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: IconButton(
                    icon:
                        Icon(Icons.add, color: Theme.of(context).primaryColor),
                    onPressed: addForm,
                  ),
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _formsList.length,
            itemBuilder: (context, index) {
              return buildForm(index);
            },
          )
        ])),
      )),
    );
  }

  void addForm() {
    _formsList.add(widget.formItems.map((e) => e.defaultValue).toList());
    setState(() {});
  }

  void deleteForm(int index) {
    _formsList.removeAt(index);
    setState(() {});
  }

  Future<void> fetchFromFirestore() async {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    List<dynamic> data = docSnap.get(widget.firebaseName) as List<dynamic>;
    _formsList = data.map((item) {
      Map<String, dynamic> i = item as Map<String, dynamic>;
      return widget.formItems.map((e) => e.getValue(i)).toList();
    }).toList();

    setState(() {});
  }

  void saveToFirestore() async {
    List<Map<String, dynamic>> data = [];

    for (int i = 0; i < _formsList.length; i++) {
      final Map<String, dynamic> item = {};
      final List<dynamic> fields = _formsList[i];
      for (int i = 0; i < widget.formItems.length; ++i) {
        widget.formItems[i].setValue(item, fields[i]);
      }
      data.add(item);
    }

    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({widget.firebaseName: data}, SetOptions(merge: true)).then(
            (documentRef) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Info Updated!!')),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: widget.nextPage),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save information')),
      );
    });
  }

  Widget buildForm(int index) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
              children: widget.formItems
                      .expand((e) =>
                          [e.build(this, context, theme), smallSpacing()])
                      .toList() +
                  [
                    padWrap(boxWrap(GestureDetector(
                      onTap: () => deleteForm(index),
                      child: const Text(
                        '  Delete  ',
                        style: TextStyle(fontSize: 17, color: Colors.redAccent),
                      ),
                    )))
                  ])),
    );
  }
}
