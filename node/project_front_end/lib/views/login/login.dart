import 'package:flutter/material.dart';
import 'package:project_front_end/widgets/captcha.dart';
import 'package:project_front_end/widgets/form_login.dart';
import 'package:universal_html/html.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLock;
  @override
  void initState() {
    isLock = true;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
        color: Colors.white
        ),
        title: Text('Verifica credenziali'),
      ),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(),
            ),
            Text('Login', style: Theme.of(context).textTheme.bodyText2,),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width/2,
              color: Colors.blueAccent.withOpacity(0.2),
              child: FormLogin(
                isLock: isLock,
              )
            ),
            Flexible(
              flex: 3,
              child: Container(),
            ),
            Captcha(
              response: setLock,
            ),
            Flexible(
              flex: 3,
              child: Container(),
            ),
          ]
        ),
      ),
    );
  }

  void setLock(lockState) {
    setState(() {
      isLock = lockState;
    });
  }
}
