import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class EditUser extends StatefulWidget {
  final List user;
  final int index;

  const EditUser({
    Key? key,
    required this.user,
    required this.index,
  }) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fullname = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> editUser() async {
    String urlSQL = "http://172.21.234.3/addressbook/edit.php";
    final uri = Uri.parse(urlSQL);
    final response = await http.post(uri, body: {
      //'key_name': variable
      //'ชื่อ Key ที่ตรงกับในไฟล์ Insert': ชื่อตัวแปรที่เก็บค่าในจากกล่องข้อความ.text
      'fullname': fullname.text,
      'username': username.text,
      'password': password.text,
    });

    print(response.statusCode); //Debug
    if (response.statusCode == 200) {
      final json = response.body;
      final data = jsonDecode(json);
      print(data); //Debug

      if (data == 'Success') {
        setState(
          () {
            Navigator.pushNamed(
              context,
              '/profile',
            );
          },
        );
      } else {
        Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 20.0,
        );
      }
    }
  }

  @override
  void initState() {
    fullname.text = widget.user[widget.index]['fullname'];
    username.text = widget.user[widget.index]['username'];
    password.text = widget.user[widget.index]['password'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit Form',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 34),
                TextFormField(
                  controller: fullname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Fullname';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Fullname",
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                    focusColor: Colors.blue,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: username,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: "Username",
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                    focusColor: Colors.blue,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: password,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Fullname';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.lightBlue[50],
                    focusColor: Colors.blue,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 170,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Navigator.pushNamed(
                              context,
                              '/profile',
                            );
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          backgroundColor: Colors.white,
                          side: const BorderSide(
                            width: 3,
                            color: Colors.blue,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            editUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}