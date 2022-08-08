import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;

class ImageInput extends StatefulWidget {
  late final Function imageData;
  ImageInput(this.imageData);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  XFile? _image;
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return;
    }
    setState(() {
      _image = image;
    });
    //to get application directory
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final imageName = path.basename(image.path);

    //this will svae the image to desired path with file name
    
    final saveimage = await image.saveTo('${appDir.path}/$imageName');

    widget.imageData(image);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(width: 1),
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: _image != null
              ? Image.file(
                  File(_image!.path),
                  width: 150,
                  fit: BoxFit.cover,
                )
              : Text(
                  'No image selected',
                  textAlign: TextAlign.center,
                ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        Expanded(
          child: ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.camera),
              label: Text('Take Image')),
        )
      ],
    );
  }
}
