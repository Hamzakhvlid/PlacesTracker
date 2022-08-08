import 'package:camera_app/view/Screens/add_places.dart';
import 'package:camera_app/Controller/provider/great_places.dart';
import 'package:camera_app/view/Screens/mapScreen.dart';
import 'package:camera_app/view/Screens/place_detail.dart';

import 'package:camera_app/view/Screens/places_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            AddPlace.routeName: (context) => AddPlace(),
            MapScreen.routeName: ((context) => MapScreen()),
            PlaceDetailScreen.routeName:((context) =>PlaceDetailScreen() ),
            PlacesListScreen.routename :(context) => PlacesListScreen(),

          },
          theme: ThemeData(
              // This is the theme of your application.
              //
              // Try running your application with "flutter run". You'll see the
              // application has a blue toolbar. Then, without quitting the app, try
              // changing the primarySwatch below to Colors.green and then invoke
              // "hot reload" (press "r" in the console where you ran "flutter run",
              // or simply save your changes to "hot reload" in a Flutter IDE).
              // Notice that the counter didn't reset back to zero; the application
              // is not restarted.

              colorScheme: ColorScheme(
                  brightness: Brightness.light,
                  primary: Color.fromARGB(255, 252, 252, 252),
                  onPrimary: Colors.black87,
                  secondary: Color.fromARGB(255, 29, 27, 27),
                  onSecondary: Colors.black87,
                  error: const Color.fromARGB(255, 255, 255, 255),
                  onError: Colors.red.shade700,
                  background: Color.fromARGB(255, 34, 34, 32),
                  onBackground: Colors.black87,
                  surface: Color.fromARGB(179, 43, 41, 41),
                  onSurface: Colors.black87)),
          home: const PlacesListScreen()),
    );
  }
}
