import 'dart:convert';

import 'package:camera_app/Controller/provider/great_places.dart';
import 'package:camera_app/helpers/location_helper.dart';

import 'package:camera_app/view/widget/image_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AddPlace extends StatefulWidget {
  const AddPlace({Key? key}) : super(key: key);

  static const String routeName = '/AddPlace';

  // ignore: prefer_const_constructors_in_immutables

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  String _previewImageUrl = "";
  late String _adress = '';
  late XFile image;
  double latitude = 0.0;
  double longitutde = 0.0;
  void _imageData(XFile newImage) {
    image = newImage;
  }

  @override
  Widget build(BuildContext context) {
    final _textEditingController = TextEditingController();

    Future<String> getAdress(double long, double lat) async {
      var url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=AIzaSyBo5ZfNM5Z47a-nrRAzUHSixShqDJmqIzA&street_address';
      var uri = Uri.parse(url);
      var response = await http.get(uri);
      print(response.body);
      return jsonDecode(response.body)['results'][0]['formatted_address']
          as String;
    }

    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://i.pinimg.com/736x/45/10/31/451031de429f443346f4e3c5a0d3bb79--beautiful-moon-beautiful-places.jpg'),
                        fit: BoxFit.cover))),
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text(style: TextStyle(color: Colors.white), 'Add Place')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(labelText: 'title'),
                  ),
                  const SizedBox(height: 10),
                  ImageInput(_imageData),
                ],
              ),
            ))),
            ElevatedButton.icon(
                icon: const Icon(Icons.map),
                label: const Text('Map'),
                onPressed: () async {
                  var data = await Location().getLocation();

                  longitutde = data.longitude!;
                  latitude = data.latitude!;

                  var adress = await getAdress(data.longitude!, data.latitude!);

                  var imageUrl = LocationHelper.generateLocationPreviewImage(
                      latitude: data.latitude!, longitude: data.longitude!);
                  setState(() {
                    _adress = adress;
                    _previewImageUrl = imageUrl;
                    longitutde = data.longitude!;
                    latitude = data.latitude!;
                  });
                }),
            Container(
              width: 100,
              height: 300,
              child: _previewImageUrl == ""
                  ? Text('No image')
                  : Image.network(_previewImageUrl),
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Save place'),
              onPressed: () {
                Provider.of<GreatPlaces>(context, listen: false).addplaces(
                    _textEditingController.text,
                    image,
                    latitude.toString(),
                    longitutde.toString(),
                    _adress,
                    _previewImageUrl);

                print(latitude);

                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
