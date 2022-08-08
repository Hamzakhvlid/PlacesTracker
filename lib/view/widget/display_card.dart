import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io' as io;

class DisplayCard extends StatelessWidget {
  late String path;
  late String title;
  late String lat;
  late String long;
  DisplayCard(this.path, this.title,this.lat,this.long);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 200,
           
            
            child: ClipRRect(
                child: Image.file(io.File(path), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(15)),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
           'latitude$lat / longitude:$long',
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 199, 198, 198),
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}
