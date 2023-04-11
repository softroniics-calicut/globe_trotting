import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:globe_trotting/place_view.dart';
import 'package:http/http.dart';

import 'constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<dynamic> getData() async {
    var res = await get(Uri.parse('${Con.url}all_places.php'));
    print(res.body);
    var result = jsonDecode(res.body);
    return (result);
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 150,
                                  width: 150,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  child: Image.network(
                                    Con.imgBase+snap.data![index]['image'],
                                    fit: BoxFit.fill,
                                    ),
                                    
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snap.data![index]['place']),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(snap.data![0]['about']),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return Place(
                                          id: snap.data[index]['place_id']);
                                    },
                                  ));
                                },
                                child: Text('View More'),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return Place(
                                        id: snap.data[index]['place_id']);
                                  },
                                ));
                              },
                              child: Icon(Icons.arrow_circle_right_outlined),
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              );
            }));
  }
}
