import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:globe_trotting/book.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class Booking extends StatefulWidget {
  Booking({super.key, required this.id});
  String id;
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  DateTime selectedDate = DateTime.now();

  Future<void> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('u_id');
    var data = {
      "id": sp,
      "package_id": widget.id,
      "amount":"1000",

    };
    print(data);
    var res = await post(Uri.parse('${Con.url}add_booking.php'), body: data);
    var rs = jsonDecode(res.body);
    print(rs);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Book();
    },));
  }

  Future<dynamic> getInfo() async {
    var data = {"id": widget.id};
    print(data);
    var res = await post(Uri.parse('${Con.url}place_view.php'), body: data);
    print(res.body);
    var response = jsonDecode(res.body);
    print(response);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: FutureBuilder(
                  future: getInfo(),
                  builder: (context, snap) {
                    if (!snap.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snap.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Amount  : ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),
                            ),
                            Text(snap.data![0]['amount'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Account no : ',style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),),
                             Text('100234567889 ',style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),)
                          ],
                        ),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('IFSC code : ',style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w300),),
                             Text('SBI000189 ',style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),)
                          ],
                        )
                      ],
                    );

                  }),
            ),
            ElevatedButton(onPressed: () {
              getData();
            }, child: Text('click here after payment transaction'))
          ],
        ),
      ),
    );
  }
}
