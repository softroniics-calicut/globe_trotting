import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'constants.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}


class _NotificationsState extends State<Notifications> {
  Future<dynamic> getData() async {
    var res = await get(Uri.parse('${Con.url}view_notification.php'));
    print(res.body);
    var rs = jsonDecode(res.body);
    return rs;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(

        future: getData(),
        builder: (context,snapshot) {
          if(snapshot.hasData){
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['title']),
                  subtitle: Text(snapshot.data![index]['cotent']),
                  // trailing: Text('date'),
                );
              },

            );
          }
          else if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          else{
            return Center(child: Text('No Notifications'));
          }

        }
      ),
    );
  }
}