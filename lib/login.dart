import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:globe_trotting/bottom.dart';
import 'package:globe_trotting/home.dart';
import 'package:globe_trotting/register.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var username = TextEditingController();
  var password = TextEditingController();
  Future<void> getData() async {
    var data = {
      "username": username.text,
      "password": password.text,
    };

    var response = await post(
        Uri.parse('http://192.168.0.106/Globe trotting/api/login.php'),
        body: data);
    var res = jsonDecode(response.body);
    print(res);

    if (response.statusCode == 200) {
      if (res['message'] == 'User Successfully LoggedIn') {
        var id = res["reg_id"];

        final spref = await SharedPreferences.getInstance();
        spref.setString('u_id', id);
        spref.setString('type', 'user');

        if (res['type'] == 'user') {
          const snackBar = SnackBar(
            content: Text('Successfully LoggedIn'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

          //  Fluttertoast.showToast(msg: 'Successfully Login...');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return MyNavigationBar();
            },
          ));
        }
      } else {
        Fluttertoast.showToast(msg: 'Invalid username or password');
      }
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong!');
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                ),
                Lottie.asset('assets/images/login.json'),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Username';
                    }
                    return null;
                  },
                  controller: username,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'username',
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Password';
                    }
                    return null;
                  },
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), hintText: 'password'),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      getData();
                    }
                  },
                  child: Container(
                    height: 50,
                    width: 150,
                    child: Center(
                        child: Text(
                      'LOGIN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                InkWell(
                    onTap: () {
                    
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Register();
                          },
                        ));
                      
                    },
                    child: Container(child: Text('create new account?'))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Con {}
