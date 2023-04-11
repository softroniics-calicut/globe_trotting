import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:globe_trotting/constants.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   var name = TextEditingController();
  var email = TextEditingController();
  var mobile = TextEditingController();
  var place = TextEditingController();
  var username = TextEditingController();
  var password = TextEditingController();

  Future<void> getData() async {
    var data = {
      "name":name.text,
      "email":email.text,
      "mobile":mobile.text,
      "place":place.text,
      "username":username.text,
      "password":password.text,

    };
    var response = await post(Uri.parse('http://192.168.0.106/Globe trotting/api/register.php'),body: data);
    print(response.body);
    if(response.statusCode==200){
       var res = jsonDecode(response.body)["message"];
       if(res=='Added'){
        const snackBar = SnackBar(
        content: Text('Successfully Registered'),
        );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

        //  Fluttertoast.showToast(msg: 'Successfully Registered...');
         Navigator.push(context, MaterialPageRoute(
           builder: (context) {
             return Login();
           },
         ));
       }

    }
    else {
      Fluttertoast.showToast(msg: 'Something went wrong!');
    }
  }
    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                    child: Text(
                  'Register',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                   validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  controller: name,
                  decoration: InputDecoration(border: OutlineInputBorder(),
                  hintText: 'name',
                    labelText: 'Enter your name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                   validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email Id';
                      }
                      return null;
                    },
                  controller: email,
                  decoration: InputDecoration(border: OutlineInputBorder(),
                    hintText: 'email',
                    labelText: 'Enter your email',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Mobile';
                      }
                      return null;
                    },
                  controller: mobile,
                  decoration: InputDecoration(border: OutlineInputBorder(),
                    hintText: 'mobile',
                    labelText: 'Enter your mobile',
                  ),
                ),
              ),
             
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                   validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Username';
                      }
                      return null;
                    },
                  controller: username,
                  decoration: InputDecoration(border: OutlineInputBorder(),
                    hintText: 'username',
                    labelText: 'Enter your username',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                   validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your Password';
                      }
                      return null;
                    },
                  controller: password,
                  decoration: InputDecoration(border: OutlineInputBorder(),
                    hintText: 'Password',
                    labelText: 'Enter your password',
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                   if (_formKey.currentState!.validate()) {
                      getData();
                    }
                },
                child: Container(
                
                  height: 40,
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(50)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}