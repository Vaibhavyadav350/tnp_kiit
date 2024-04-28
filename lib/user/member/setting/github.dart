import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../theme/vytext.dart';
class GitHubProjectInfoPage extends StatefulWidget {
  @override
  _GitHubProjectInfoPageState createState() => _GitHubProjectInfoPageState();
}
class _GitHubProjectInfoPageState extends State
{
  TextEditingController _controller = TextEditingController();
  String _repositoryName = '';
  String _description = '';
  String _language = '';
  int _stars = 0;
  int _forks = 0;
  int _watchers = 0;
  String _error = '';
  List<Map<String, dynamic>> _contributors = [];
  List<String> _topics = [];
  Future<void> _fetchProjectInfo(String url) async {
    try {
      Uri uri = Uri.parse(url);
      List<String> pathSegments = uri.pathSegments;
      String username = pathSegments[0];
      String repository = pathSegments[1];
      http.Response response = await http.get(
        Uri.https('api.github.com', '/repos/$username/$repository'),
      );

      Map<String, dynamic> data = json.decode(response.body);

      http.Response contributorsResponse = await http.get(
        Uri.https('api.github.com', '/repos/$username/$repository/contributors'),
      );
      List<dynamic> contributorsData = json.decode(contributorsResponse.body);
      setState(() {
        _contributors = contributorsData.map<Map<String, dynamic>>((contributor) => {
          'login': contributor['login'],
          'contributions': contributor['contributions'],
        }).toList();

        _repositoryName = data['name'];
        _description = data['description'];
        _language = data['language'];
        _stars = data['stargazers_count'];
        _forks = data['forks_count'];
        _watchers = data['watchers_count'];
        _topics = List<String>.from(data['topics']);

        _error = ''; // Reset error message
      });
    } catch (e) {
      setState(() {
        _error = 'Error: Unable to fetch project information.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub Project Info'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VyText(_controller,"Enter Github Link",Icons.network_cell_sharp),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String url = _controller.text.trim();
                if (url.isNotEmpty) {
                  _fetchProjectInfo(url);
                }
              },
              child: Text('Fetch Project Info'),
            ),
            SizedBox(height: 20.0),
            if (_error.isNotEmpty)
              Text(
                _error,
                style: TextStyle(color: Colors.red),
              ),
            if (_repositoryName.isNotEmpty) ...[
              BoldText('Repository Name: ','$_repositoryName'),
              BoldText('Description:',' $_description'),
              BoldText('Language:',' $_language'),
              BoldText('Stars: ','$_stars'),
              BoldText('Forks:',' $_forks'),
              BoldText('Watchers:',' $_watchers'),

              Row(

                children: [
                  Wrap(
                    children: _topics.map((topic) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Chip(label: Text(topic,style: TextStyle(color: Colors.white),)),
                    )).toList(),
                  ),
                ],
              ),
              if (_contributors.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _contributors.map((contributor) => BoldText('${contributor['login']} -',' ${contributor['contributions']} contributions')).toList(),
                )
              else
                Text('No contributors found.'),
            ],
          ],
        ),
      ),
    );
  }
}

