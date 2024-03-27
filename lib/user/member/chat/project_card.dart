import 'package:flutter/material.dart';

Widget buildProjectCard({
  required String projectName,
  required String projectDescription,
  String? imageUrl,
  String? userImage,
  List<String>? tags,
  String? status,
  String? userEmail,
  List<String>? links,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 14),
        child: Row(
          children: [
            SizedBox(
              height: 40,width: 40,
              child: ClipRRect(
                child: Image.network(
                  userImage!,
                  fit: BoxFit.cover,
                ),borderRadius: BorderRadius.circular(100),
              ),
            ),
            Text("   $userEmail"
              ,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ],
        ),
      ),
      if (imageUrl != null)
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              projectName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              projectDescription,
              style: TextStyle(fontSize: 15,color: Colors.white),
            ),
            SizedBox(height: 8),
            if (tags != null && tags.isNotEmpty)
              Wrap(
                spacing: 8,
                children: tags.map((tag) => Chip(label: Text(tag,style: TextStyle(fontSize: 15,color: Colors.white),))).toList(),
              ),
            if (status != null) SizedBox(height: 8),
            if (status != null)
              Text(
                'Status: $status',
                style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic,color: Colors.white),
              ),
            SizedBox(height: 8),
            if (links != null && links.isNotEmpty)
              Wrap(
                spacing: 8,
                children: links
                    .map(
                      (link) => Text(link,style: TextStyle(color: Colors.blue,fontSize: 15)), // Added closing parenthesis here
                )
                    .toList(),
              ),
          ],
        ),
      ),
    ],
  );
}