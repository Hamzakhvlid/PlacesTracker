import 'package:camera_app/models/place.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'dart:io' as io;

import 'package:intl/intl.dart';
class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/placedetail';

  @override
  Widget build(BuildContext context) {
     var object= ModalRoute.of(context)?.settings.arguments as Place;
     
     
    return Scaffold(

        appBar: AppBar(
          title: Text(object.title),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
         ClipRRect(
                
                child: Image.file(io.File(object.image.path), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(8)),
          const SizedBox(height: 10,),
          Text('Adress:',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
           const SizedBox(height: 5,),
          Text(object.adrees),


          const SizedBox(height: 10,),
           Text('date:',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
          Text(object.id),

          SizedBox(height: 10,),
          Text(object.latitude),
           SizedBox(height: 5),
          Text(object.longitude),

           Text('Map SnapShot :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
          ClipRRect(
            child: 
              Image.network(object.mapUrl),
              borderRadius: BorderRadius.circular(10) ,
            
          )]),
        
        
        ));
  }
}
