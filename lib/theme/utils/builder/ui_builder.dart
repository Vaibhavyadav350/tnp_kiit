// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kiit_connect/theme/colors.dart';
import 'package:kiit_connect/theme/utils/builder/miscellaneous.dart';
import 'package:kiit_connect/theme/utils/text/neo_box.dart';
import 'package:kiit_connect/theme/utils/text/vytext.dart';

import '../button/vybutton_.dart';

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

  String keywordToSentence() {
    return split(RegExp("(?=[A-Z])")).join(" ");
  }
}

class FormItem2 extends StatelessWidget {
  final String displayName; // TODO: Remove this field, since it's never used
  final dynamic Function() serialize;
  final void Function(dynamic) deserialize;
  final Widget Function(BuildContext) builder;
  bool Function() isValid = () => true;

  FormItem2(
      {super.key,
      required this.displayName,
      required this.serialize,
      required this.deserialize,
      required this.builder});

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}

bool Function(List<FormItem2>) fieldPredicate(
        String displayName, bool Function(dynamic) predicate) =>
    (list) => predicate(list
        .where((e) => e.displayName == displayName)
        .firstOrNull!
        .serialize());

bool Function(List<FormItem2>) fieldEquals(String displayName, dynamic value) =>
    fieldPredicate(displayName, (e) => e == value);

class FormItemSupplier {
  late final String firebaseKey;
  final FormItem2 Function(void Function(VoidCallback fn)) supplier;
  bool Function(List<FormItem2>) validatingCondition = (_) => true;

  FormItemSupplier(
      {required this.supplier,
      String? displayName,
      validatingCondition,
      firebaseKey}) {
    this.firebaseKey = firebaseKey ?? displayName!.toFormattableKey();
    this.validatingCondition = validatingCondition ?? this.validatingCondition;
  }
}

class FormBuilder {
  final List<FormItemSupplier> formPress = [];
  var maximumInstances = 10;

  // GUIDE FOR ADDING MORE UI ELEMENT BUILDERS
//   FormBuilder add<ElementName>(displayName,
//       {
//        defaultValue = "",
//        firebaseKey,
//        validatingCondition,
//        ... other args
//       }) {
//     formPress.add(FormItemSupplier(
//         displayName: displayName,
//         firebaseKey: firebaseKey,
//         validatingCondition: validatingCondition,
//         supplier: (setState) {
//           <CREATE MUTABLE VARIABLE HERE>
//           return FormItem2(
//               displayName: displayName,
//               serialize: () => VARIABLE,
//               deserialize: (value) => VARIABLE = value,
//               builder: (context) {
//                 return <YOUR UI ELEMENT WHICH USES THE VARIABLE>;
//         }));
//     return this;
//   }

  FormBuilder addGitHubRepoInput(displayName,
      {restrictGHUID, firebaseKey, validatingCondition}) {
    formPress.add(FormItemSupplier(
        displayName: displayName,
        firebaseKey: firebaseKey,
        validatingCondition: validatingCondition,
        supplier: (setState) {
          final TextEditingController controller = TextEditingController();
          String projectDescription = '';
          dynamic _contributors = [];
          dynamic _repositoryName = '';
          dynamic _description = '';
          dynamic _language = '';
          dynamic _stars = 0;
          dynamic _forks = 0;
          dynamic _watchers = 0;
          dynamic _topics = [];
          dynamic _error = '';

          return FormItem2(
              displayName: displayName,
              serialize: () => {
                    'controller': controller.text,
                    'projectDescription': projectDescription,
                    '_contributors': _contributors,
                    '_repositoryName': _repositoryName,
                    '_description': _description,
                    '_language': _language,
                    '_stars': _stars,
                    '_forks': _forks,
                    '_watchers': _watchers,
                    '_topics': _topics,
                    '_error': _error,
                  },
              deserialize: (value) {
                controller.text = value['controller'];
                projectDescription = value['projectDescription'];
                _contributors = value['_contributors'];
                _repositoryName = value['_repositoryName'];
                _description = value['_description'];
                _language = value['_language'];
                _stars = value['_stars'];
                _forks = value['_forks'];
                _watchers = value['_watchers'];
                _topics = value['_topics'];
                _error = value['_error'];
              },
              builder: (context) {
                return StatefulBuilder(
                  builder: (ccd, setState2) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        children: [
                          VyTextsmall(controller, "Github Repo", Icons.code),
                          VyButtonsmall("Fetch", Icons.download, () async {
                            try {
                              final repoUrl = controller.text.trim();
                              Uri uri = Uri.parse(repoUrl);
                              List<String> pathSegments = uri.pathSegments;
                              String username = pathSegments[0];

                              String repository = pathSegments[1];
                              http.Response response = await http.get(
                                Uri.https('api.github.com',
                                    '/repos/$username/$repository'),
                              );

                              Map<String, dynamic> data =
                                  json.decode(response.body);

                              http.Response contributorsResponse =
                                  await http.get(
                                Uri.https('api.github.com',
                                    '/repos/$username/$repository/contributors'),
                              );
                              List<dynamic> contributorsData =
                                  json.decode(contributorsResponse.body);

                              BLOCK:
                              if (restrictGHUID != null) {
                                for (int i = 0;
                                    i < contributorsData.length;
                                    i++) {
                                  if (restrictGHUID(
                                      contributorsData[i]['login']))
                                    break BLOCK;
                                }
                                throw FormatException();
                              }
                              setState(() => setState2(() {
                                    _contributors = contributorsData
                                        .map<Map<String, dynamic>>(
                                            (contributor) => {
                                                  'login': contributor['login'],
                                                  'contributions': contributor[
                                                      'contributions'],
                                                })
                                        .toList();
                                    _repositoryName = data['name'];
                                    _description = data['description'];
                                    _language = data['language'];
                                    _stars = data['stargazers_count'];
                                    _forks = data['forks_count'];
                                    _watchers = data['watchers_count'];
                                    _topics = List<String>.from(data['topics']);
                                    print(_contributors);
                                    print(_description);
                                    _error = ''; // Reset error message
                                  }));
                            } on FormatException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: AwesomeSnackbarContent(
                                    title: 'Wrong Project!!',
                                    message:
                                        'You are not a contributor to this project!!',
                                    contentType: ContentType.failure,
                                  ),
                                  backgroundColor: Colors
                                      .transparent, // Set your desired color
                                ),
                              );
                            } catch (e) {
                              setState(() {
                                _error =
                                    'Error: Unable to fetch project information.';
                              });
                            }
                          }),
                        ],
                      ),
                      SizedBox(height: 10),
                      if (_repositoryName.isNotEmpty) ...[
                        BoldText('Repository Name: ', _repositoryName),
                        BoldText('Description:', ' $_description'),
                        BoldText('Language:', ' $_language'),
                        BoldText('Stars: ', '$_stars'),
                        BoldText('Forks:', ' $_forks'),
                        BoldText('Watchers:', ' $_watchers'),
                        Row(
                          children: [
                            Wrap(
                              children: _topics
                                  .map<Widget>((topic) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        child: Chip(
                                            label: Text(
                                          topic,
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                        if (_contributors.isNotEmpty)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _contributors
                                .map<Widget>((contributor) => BoldText(
                                    '${contributor['login']} -',
                                    ' ${contributor['contributions']} contributions'))
                                .toList(),
                          )
                        else
                          Text('No contributors found.'),
                      ],
                    ],
                  ),
                );
              });
        }));
    return this;
  }

  FormBuilder addTextField(displayName,
      {defaultValue = "",
      maxLines = 1,
      hintText = "",
      icon,
      firebaseKey,
      keyboardType,
      validatingCondition}) {
    formPress.add(FormItemSupplier(
        displayName: displayName,
        firebaseKey: firebaseKey,
        validatingCondition: validatingCondition,
        supplier: (setState) {
          final TextEditingController controller =
              TextEditingController(text: defaultValue);
          return FormItem2(
              displayName: displayName,
              serialize: () => controller.text,
              deserialize: (value) => controller.text = value,
              builder: (context) {
                return MatTextField(
                    label: displayName,
                    controller: controller,
                    maxLines: maxLines,
                    hintText: hintText,
                    icon: icon,
                    keyboardType: keyboardType);
              });
        }));
    return this;
  }

  FormBuilder addComboBox(displayName, List<String> validValues,
      {defaultValue, firebaseKey, validatingCondition}) {
    defaultValue = defaultValue ?? validValues[0];
    formPress.add(FormItemSupplier(
        displayName: displayName,
        firebaseKey: firebaseKey,
        validatingCondition: validatingCondition,
        supplier: (setState) {
          String selectedValue = defaultValue;
          return FormItem2(
              displayName: displayName,
              serialize: () => selectedValue,
              deserialize: (value) => selectedValue = value,
              builder: (context) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    padWrap(Text(displayName, style: textAnnotation(context))),
                    padWrap((DropdownButtonFormField<String>(
                      value: selectedValue,
                      decoration: inputDecoration(),
                      items: validValues.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) =>
                          setState(() => selectedValue = newValue!),
                      style: textAnnotation(context),
                    )))
                  ],
                );
              });
        }));
    return this;
  }

  FormBuilder addMultiSelectComboBox(displayName, List<String> validValues,
      {firebaseKey, validatingCondition}) {
    formPress.add(FormItemSupplier(
        displayName: displayName,
        firebaseKey: firebaseKey,
        validatingCondition: validatingCondition,
        supplier: (setState) {
          List<String> selectedValues = [];
          return FormItem2(
              displayName: displayName,
              serialize: () => selectedValues,
              deserialize: (value) =>
                  selectedValues = List<String>.from(value ?? []),
              builder: (context) {
                return padWrap(boxWrap(
                    PopupMenuButton<String>(
                      child: ListTile(
                        title:
                            Text(displayName, style: textAnnotation(context)),
                        trailing: Icon(Icons.arrow_drop_down,
                            color: Theme.of(context).primaryColor),
                      ),
                      itemBuilder: (BuildContext context) {
                        return validValues.map((String skillItem) {
                          return PopupMenuItem<String>(
                            value: skillItem,
                            child: StatefulBuilder(
                                builder: (context, innerSetState) {
                              return CheckboxListTile(
                                title: Text(skillItem),
                                value: selectedValues.contains(skillItem),
                                activeColor: Colors.black,
                                onChanged: (bool? value) {
                                  // Navigator.of(context).pop(); // close the menu
                                  if (value != null) {
                                    if (value) {
                                      selectedValues.add(skillItem);
                                    } else {
                                      selectedValues.remove(skillItem);
                                    }
                                    setState(() {});
                                    innerSetState(() {});
                                  }
                                },
                              );
                            }),
                          );
                        }).toList();
                      },
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0)));
              });
        }));
    return this;
  }

  FormBuilder addMultiTextBox(displayName, {firebaseKey, validatingCondition}) {
    formPress.add(FormItemSupplier(
        displayName: displayName,
        firebaseKey: firebaseKey,
        validatingCondition: validatingCondition,
        supplier: (setState) {
          final controllers = [TextEditingController()];
          return FormItem2(
              displayName: displayName,
              serialize: () => controllers.map((e) => e.text).toList(),
              deserialize: (value) {
                controllers.clear();
                value
                    .map((e) => TextEditingController(text: e))
                    .forEach((e) => controllers.add(e));
              },
              builder: (context) {
                return MultiTextBox(
                    label: displayName, controllers: controllers);
              });
        }));
    return this;
  }

  FormBuilder addFileUploadButton(displayName,
      {firebaseKey,
      validatingCondition,
      FileType type = FileType.any,
      List<String>? allowedExtensions}) {
    formPress.add(FormItemSupplier(
        displayName: displayName,
        firebaseKey: firebaseKey,
        validatingCondition: validatingCondition,
        supplier: (setState) {
          String url = "";
          return FormItem2(
              displayName: displayName,
              serialize: () => url,
              deserialize: (value) => url = value,
              builder: (context) => padWrap(boxWrap(GestureDetector(
                  onTap: () async {
                    url = (await pickAndUploadSupportedDoc(
                            type: type,
                            allowedExtensions: allowedExtensions)) ??
                        "";
                    if (url.isNotEmpty) {
                      setState(() {}); // to refresh the UI
                    }
                  },
                  child: Center(
                      child: Text('Select $displayName',
                          style: textAnnotation(context)))))));
        }));
    return this;
  }

  FormBuilder addCheckbox(displayName, {firebaseKey, validatingCondition}) {
    formPress.add(FormItemSupplier(
        displayName: displayName,
        firebaseKey: firebaseKey,
        validatingCondition: validatingCondition,
        supplier: (setState) {
          bool state = false;
          return FormItem2(
              displayName: displayName,
              serialize: () => state,
              deserialize: (value) => state = value,
              builder: (context) => padWrap(boxWrap(
                  StatefulBuilder(
                      builder: (context, iSetState) => CheckboxListTile(
                            activeColor: Colors.black,
                            title: Text(
                              displayName,
                              style: textAnnotation(context),
                            ),
                            value: state,
                            onChanged: (value) =>
                                setState(() => iSetState(() => state = value!)),
                          )),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0))));
        }));
    return this;
  }

  Talika build(displayTitle, nextPage, {firebaseKey}) {
    return Talika(Stencil(formPress), displayTitle, nextPage, maximumInstances,
        firebaseKey: firebaseKey);
  }

  FormBuilder limitMaximumInstancesTo(int length) {
    maximumInstances = length;
    return this;
  }
}

class Stencil {
  final List<FormItemSupplier> formPress;

  Stencil(this.formPress);

  List<FormItem2> newForm(void Function(VoidCallback fn) setState) {
    var formItems = formPress.map((e) => e.supplier(setState)).toList();
    for (var i = 0; i < formPress.length; i++)
      formItems[i].isValid = () => formPress[i].validatingCondition(formItems);
    return formItems;
  }

  Map<String, dynamic> serialize(List<FormItem2> list) {
    assert(list.length == formPress.length);
    return Map.fromEntries(formPress.indexed
        .map((e) => MapEntry(e.$2.firebaseKey, list[e.$1].serialize())));
  }

  List<FormItem2> deserialize(
      Map<String, dynamic> map, void Function(VoidCallback fn) setState) {
    assert(map.length == formPress.length);
    return formPress.map((e) {
      var f = e.supplier(setState);
      f.deserialize(map[e.firebaseKey]!);
      return f;
    }).toList();
  }
}

class Talika extends StatefulWidget {
  final Stencil stencil;
  final String displayTitle;
  final int maximumInstances;
  final Widget Function(BuildContext) nextPage;
  late final String firebaseKey;

  Talika(this.stencil, this.displayTitle, this.nextPage, this.maximumInstances,
      {firebaseKey, super.key}) {
    this.firebaseKey = firebaseKey ?? displayTitle.toFormattableKey();
  }

  @override
  State<Talika> createState() => _TalikaState();
}

class _TalikaState extends State<Talika> {
  final _formKey = GlobalKey<FormState>();
  List<List<FormItem2>> forms = [];

  void addForm() {
    if (widget.maximumInstances == -1 || forms.length < widget.maximumInstances)
      setState(() => forms.add(widget.stencil.newForm(setState)));
    else
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Maximum of ${widget.maximumInstances} reached!')));
  }

  void deleteForm(int index) => setState(() => forms.removeAt(index));

  @override
  void initState() {
    super.initState();
    fetchFromFirestore();
  }

  Future<void> fetchFromFirestore() async {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    print("HERERREE: " + docSnap.toString());
    setState(() {
      // var data = docSnap.get(widget.firebaseKey) as List<Map<String, String>>;
      var data = docSnap.get(widget.firebaseKey) as List<dynamic>;
      forms = data
          .map((e) =>
              widget.stencil.deserialize(e as Map<String, dynamic>, setState))
          .toList();
    });
  }

  void saveToFirestore() async {
    List<Map<String, dynamic>> data =
        forms.map((e) => widget.stencil.serialize(e)).toList();
    print("SAVING THE FOLLOWING TO FIRESTORE!!$data");
    await FirebaseFirestore.instance
        .collection('StudentInfo')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({widget.firebaseKey: data}, SetOptions(merge: true)).then(
            (documentRef) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Oh Nice!!',
            message: 'Info Updated!!',
            contentType: ContentType.success,
          ),
          backgroundColor: Colors.transparent, // Set your desired color
        ),
      );
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: widget.nextPage));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Oh No!!',
            message: 'Failed to save information',
            contentType: ContentType.failure,
          ),
          backgroundColor: Colors.transparent, // Set your desired color
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (forms.isEmpty) addForm();
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              saveToFirestore();
            }
          },
          label: Text('Proceed', style: textAnnotation(context)),
          icon: const Icon(Icons.keyboard_double_arrow_right,
              color: Colors.black),
          backgroundColor: greenHighlight,
        ),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: SingleChildScrollView(child: mainBody(context)),
        )));
  }

  Widget mainBody(BuildContext context) {
    List<String> exclusionList = [
      "Public Profile",
      "Minor Project",
      "Major Project"
    ];
    bool showAddIcon = !exclusionList.contains(widget.displayTitle);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: 60,
                width: 60,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new,
                      color: Theme.of(context).primaryColor),
                  // TODO: Verify that it still works
                  onPressed: () => Navigator.pop(context),
                )),
            Text(widget.displayTitle, style: textTitle(context)),
            if(!showAddIcon)
              SizedBox(width: 60,),
            if (showAddIcon) 
              SizedBox(
                height: 60,
                width: 60,
                child: IconButton(
                  icon: Icon(Icons.add, color: Theme.of(context).primaryColor),
                  onPressed: addForm,
                ),
              )
          ],
        ),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: forms.length,
        itemBuilder: (context, index) {
          return buildForm(context, index);
        },
      )
    ]);
  }

  Widget buildForm(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
              children: forms[index]
                      .where((e) => e.isValid())
                      // .expand((e) => [e, smallSpacing()])
                      .map((e) => e as Widget)
                      .toList() +
                  [
                    padWrap(boxWrap(GestureDetector(
                      onTap: () => deleteForm(index),
                      child: const Text('  Delete  ',
                          style: TextStyle(fontSize: 17, color: Colors.red)),
                    )))
                  ])),
    );
  }
}
