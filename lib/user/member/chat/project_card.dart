import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:kiit_connect/theme/colors.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget buildProjectCard({
  required String projectName,
  required String projectDescription,
  String? imageUrl,
  String? userImage,
  List<String>? tags,
  String? status,
  String? userEmail,
  String? link,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: SizedBox(
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  userImage!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(
              "$userEmail",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            trailing: Chip(
              side: BorderSide.none,
              backgroundColor: Colors.blue.shade50,
              avatar: Icon(FluentIcons.collections_24_regular,color: Colors.blue,),
              label: Text(
                "Collab",
                style: TextStyle(color: Colors.blue),
              ),
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
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  projectDescription,
                  style: const TextStyle(fontSize: 15,color: Colors.black),
                ),
                const SizedBox(height: 8),
                if (tags != null && tags.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    children: tags
                        .map((tag) => Chip(
                      backgroundColor: Colors.grey.shade50,
                                side: BorderSide.none,
                                label: Text(
                              tag,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.blue),
                            )))
                        .toList(),
                  ),
                if (status != null) const SizedBox(height: 8),
                if (status != null)
                  Text(
                    'Status: $status',
                    style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.green),
                  ),
                const SizedBox(height: 8),
                if (link != null && link.isNotEmpty)
                  GestureDetector(
                    onTap: (){
                      if(link.startsWith("https://")|| link.startsWith("http://"))
                      launchUrlString(link);
                      else{
                        String newlink = "https://$link";
                        launchUrlString(newlink);
                      }
                    },
                    child: Chip(
                      backgroundColor: Colors.grey.shade200,
                        side:BorderSide.none,
                        avatar: Icon(FluentIcons.code_24_filled,color: Colors.green,size: 20,),
                        label: Text(link,style: TextStyle(color: Colors.green),)),
                  )


              ],
            ),
          ),
        ],
      ),
    ),
  );
}
