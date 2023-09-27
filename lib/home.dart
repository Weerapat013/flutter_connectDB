import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_connectdbdemo/update.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> users = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future getData() async {
    const url = "http://172.21.234.3/addressbook/select.php";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    //print(response.statusCode); //Debug
    if (response.statusCode == 200) {
      final json = response.body;
      final data = jsonDecode(json);

      setState(() {
        users = data;
        //print(users);  //Debug
      });
    } else {
      //print('Error Connection'); //Debug
    }
  }

  Future deleteUser(username) async {
    const url = "http://172.21.245.138/addressbook/delete.php";
    final uri = Uri.parse(url);
    var userData = {};

    userData['username'] = username;
    final response = await http.post(uri, body: userData);
    print(response.statusCode); //Debug
    if (response.statusCode == 200) {
      final json = response.body;
      final result = jsonDecode(json);

      if (result == "Success") {
        print('Delete User Success');
        getData();
      } else {
        Fluttertoast.showToast(
          msg: "Delete User Error",
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final username = users[index]['username'];
            final fullname = users[index]['fullname'];
            return ListTile(
              leading: GestureDetector(
                child: CircleAvatar(
                  child: Text(fullname[0]),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateUser(
                        user: users,
                        index: index,
                      ),
                    ),
                  );
                },
              ),
              title: Text(fullname),
              subtitle: Text(username),
              trailing: GestureDetector(
                child: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.blue,
                ),
                onTap: () {
                  deleteUser(username);
                },
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/register',
          );
        },
        child: const Icon(
          Icons.person_add_alt_1,
          size: 30,
        ),
      ),
    );
  }
}
