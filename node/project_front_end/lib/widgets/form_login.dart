import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project_front_end/views/common/token.dart';
import 'package:project_front_end/views/gallery/gallery.dart';

class FormLogin extends StatefulWidget {
  bool isLock;
  FormLogin({this.isLock});
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  String _username;
  String _password;
  bool showIncorrectMessage = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          onChanged: () => setState(() {
            showIncorrectMessage = false;
          }),
          key: _formKey,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    hintText: 'Mario Rossi',
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter username';
                    return null;
                  },
                  onSaved: (input) => _username = input,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '123456789',
                  ),
                  validator: (value) {
                    if (value.isEmpty)
                      return 'Please enter username';
                    return null;
                  },
                  onSaved: (input) => _password = input,
                ),
                Row(
                  children: [
                    showIncorrectMessage
                      ? Text(
                          'username e password non corrispondono',
                          style: Theme.of(context).textTheme.bodyText1.apply(fontSizeFactor: 0.6, color: Colors.redAccent)
                        )
                      : Container(),
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                    FlatButton(
                      child: Text('Submit'),
                      onPressed: widget.isLock
                        ? null
                        : () => {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save(),
                          sendCredentials().then((value) =>  {
                            value != 'false' && value != null 
                                ? {Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Gallery()),
                            ),
                              IdRepository.save(value)
                            }
                                : setState(() {
                              showIncorrectMessage = true;
                            }),
                          }
                          )
                        }
                      }
                    ),
                  ]
                )
              ]
          ),
        ),

      ]
    );
  }

  Future<String> sendCredentials() async {
    final http.Response response = await http.post(
      'http://localhost:3000/post/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _username,
        'password': _password,
      }),
    );
    if (response.statusCode == 200) {
      return Future.value(response.body);
    } else {
      return Future.value('false');
    }
  }
}
