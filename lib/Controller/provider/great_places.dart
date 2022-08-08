import 'package:camera_app/helpers/helpers_db.dart';
import 'package:camera_app/models/place.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class GreatPlaces with ChangeNotifier {
  late List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addplaces(String title, XFile place, String lat, String long,
      String adress, String mapUrl) async {
    await DBhelper.insert('placesTable', {
      'id': DateTime.now().toString(),
      'title': title,
      'image': place.path,
      'lat': lat.toString(),
      'long': long.toString(),
      'mapUrl': mapUrl,
      'adress': adress
    });

    notifyListeners();
  }

  Future<void> getAndSet() async {
    final value = await DBhelper.getData('placesTable');
    _items = value.map((e) {
      return Place(
          id: e['id'],
          title: e['title'],
          image: XFile(e['image']),
          longitude: e['long'],
          latitude: e['lat'],
          mapUrl: e['mapUrl'],
          adrees: e['adress']);
    }).toList();
    print('----------------------------------------');
    print(_items.length);

    notifyListeners();
  }
}
