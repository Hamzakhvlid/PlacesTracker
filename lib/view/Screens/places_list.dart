
import 'package:camera_app/view/Screens/MapScreen.dart';
import 'package:camera_app/view/widget/display_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:camera_app/Controller/provider/great_places.dart';

import 'package:provider/provider.dart';

import 'add_places.dart';
import 'package:flutter/material.dart';
import 'place_detail.dart';

class PlacesListScreen extends StatefulWidget {
  const PlacesListScreen({Key? key}) : super(key: key);
  static String routename='/placelist';

  @override
  State<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends State<PlacesListScreen> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color.fromARGB(255, 44, 44, 45),
          color: Color.fromARGB(255, 250, 247, 247),
          items: <Widget>[
            Icon(Icons.list, size: 30),
            Icon(Icons.camera ,size: 30),
            Icon(Icons.map, size: 30)
          ],
          onTap: (index) {
            if (index == 2) {
              Navigator.of(context).pushNamed(MapScreen.routeName);
              
                index = 0;
              
            } else if (index == 1) {
              Navigator.of(context).pushNamed(AddPlace.routeName);
              
                index = 0;
              
            }
            else 
            {
               Navigator.of(context).pushNamed(PlacesListScreen.routename);
            }
            
              
            

            //Handle button tap
          },
        ),
        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () =>
                      Navigator.of(context).pushNamed(AddPlace.routeName),
                  icon: const Icon(Icons.add_a_photo))
            ],
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text('CameraApp')),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false).getAndSet(),
          builder: ((context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: Center(child: Text("No items aded yet")),
                  builder: (context, value, child) => value.items.length == 0
                      ? child!
                      : RefreshIndicator(
                          onRefresh: () =>
                              Provider.of<GreatPlaces>(context, listen: false)
                                  .getAndSet(),
                          child: ListView.builder(
                              itemCount: value.items.length,
                              itemBuilder: ((context, index) =>InkWell(onDoubleTap: (() => Navigator.of(context).pushNamed('/placedetail',arguments: value.items[index])),
                                 child: DisplayCard(
                                  value.items[index].image.path,
                                  value.items[index].title,
                                  value.items[index].latitude,
                                  value.items[index].longitude))),
                                  ),
                        ))),
        ));
  }
}
