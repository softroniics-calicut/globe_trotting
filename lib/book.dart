import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Book extends StatefulWidget {
  const Book({super.key});

  @override
  State<Book> createState() => _BookState();
}

class _BookState extends State<Book> {
 Future<dynamic> getData() async {
  SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('u_id');
    print(sp);
    var data={
      "id":sp,
    };
 var res = await post(Uri.parse('${Con.url}booking_history.php'),body: data);
 print(res.body);
 var r = jsonDecode(res.body);
 return r;
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
                  title: Text(snapshot.data[index]['place']),
                  subtitle: Text(snapshot.data[index]['date']),
                
                  trailing: Text(snapshot.data[index]['status']),
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