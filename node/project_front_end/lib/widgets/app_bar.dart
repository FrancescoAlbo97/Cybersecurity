import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_front_end/views/login/login.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget  {
  @override
  Size get preferredSize => const Size.fromHeight(56);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('Progetto cyber security'),
      actions: [
        Padding(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
            ),
            color: Colors.white,
            child: Text('Login', style: TextStyle(color: Colors.blue),),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            ),
          ),
        )
      ],
    );
  }
}
