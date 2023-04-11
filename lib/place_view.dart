import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'booking.dart';
import 'constants.dart';

class Place extends StatefulWidget {
  Place({super.key, required this.id});
  String id;

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  Future<dynamic> getData() async {
    var data = {
      "id": widget.id,
    };
    var res = await post(Uri.parse('${Con.url}place_view.php'), body: data);
    var result = jsonDecode(res.body);
    print(res.body);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.amber,
                  child: Image.network(
                    Con.imgBase + snap.data![0]['image'],
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                      child: Text(
                    '${snap.data![0]['place']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'About',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(snap.data![0]['about']),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Details',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(snap.data![0]['details']),
                ),
                 Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Fecilities',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8,left: 25,),
                  child: Row(
                    children: [
                      Icon(Icons.home),
                       Padding(
                         padding: const EdgeInsets.only(left: 20),
                         child: Text('Hotel'),
                       )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8,left: 25,),
                  child: Row(
                    children: [
                      Icon(Icons.hotel),
                       Padding(
                         padding: const EdgeInsets.only(left: 20),
                         child: Text('Room'),
                       )
                    ],
                  ),
                ),

                 Padding(
                  padding: const EdgeInsets.only(top: 8,left: 25,),
                  child: Row(
                    children: [
                      Icon(Icons.tour_outlined),
                       Padding(
                         padding: const EdgeInsets.only(left: 20),
                         child: Text('Sight Seeing'),
                       )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8,left: 25,),
                  child: Row(
                    children: [
                      Icon(Icons.emoji_transportation),
                       Padding(
                         padding: const EdgeInsets.only(left: 20),
                         child: Text('Transportation'),
                       )
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return Booking(id: snap.data[0]['place_id']);
                      },
                    ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      color: Colors.blue,
                      child: Center(
                          child: Text(
                        'Book',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
