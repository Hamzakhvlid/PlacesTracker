import 'package:image_picker/image_picker.dart';

class Place {
  late String id;
  late String title;
  late XFile image;
  late String latitude;
  late String longitude;
  late String adrees;
  late String mapUrl;

  Place({
    required this.id,
    required this.title,
    required this.image,
    required this.latitude,
    required this.longitude,
    required this.adrees,
    required this.mapUrl
  });
}
