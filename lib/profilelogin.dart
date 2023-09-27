import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_connectdbdemo/edituser.dart';
import 'package:http/http.dart' as http;

class ProfileLogin extends StatefulWidget {
  const ProfileLogin({super.key});

  @override
  State<ProfileLogin> createState() => _ProfileLoginState();
}

class _ProfileLoginState extends State<ProfileLogin> {
  List<dynamic> user = [];

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future getUser() async {
    //const url = "http://172.21.234.3/addressbook/select_user.php";
    const url = "http://172.21.234.3/addressbook/select.php";
    final uri = Uri.parse(url);
    final response = await http.post(uri);

    print(response.statusCode);
    if (response.statusCode == 200) {
      final json = response.body;
      final data = jsonDecode(json);

      setState(() {
        user = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final Map username = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: ListView.builder(
          itemCount: user.length,
          itemBuilder: (context, index) {
            final username = user[index]['username'];
            final fullname = user[index]['fullname'];
            return ListTile(
              leading: GestureDetector(
                child: const CircleAvatar(
                  //backgroundColor: Colors.cyan,
                  child: Icon(Icons.edit),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditUser(
                        user: user,
                        index: index,
                      ),
                    ),
                  );
                },
              ),
              title: Text(username),
              subtitle: Text(fullname),
            );
          }),
    );
  }
}
