import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';


class Captcha extends StatefulWidget {
  final List<String> images = ['bird','flowers','mountain'];
  final Function response;
  Captcha({this.response});
  @override
  _CaptchaState createState() => _CaptchaState();
}

class _CaptchaState extends State<Captcha> {
  final GlobalKey key = GlobalKey();
  final _random = Random();
  int lifes = 5;
  bool flag = true;
  double startAngle = 0;
  int image;
  double angle;
  double deltaAngle = 0;
  @override
  void initState() {
    image = _random.nextInt(3);
    angle = _random.nextDouble()*2*pi;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return
        Row(
          mainAxisSize: MainAxisSize.min,
          children:[
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(75)),
              child: GestureDetector(
                onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) => {onKeepPress(context, details)},
                onLongPressEnd: (_) {
                  if (lifes > 0) {
                    widget.response(checkAngle());
                    if (checkAngle())
                      lifes -= 1;
                  }
                  setState(() {
                    flag = true;
                  });
                },
                child: Container(
                  key: key,
                  height: 150,
                  width: 150,
                  child: Transform.rotate(
                      angle: angle + deltaAngle,
                      child: Image.asset('images/' + widget.images[image].toString() + '.jpg')
                  ),
                )
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Tenere premuto un punto \ndell\'immagine e ruotarla correttamente \nper abilitare l\'accessso.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w200)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 20),
                  child: Chip(
                    avatar: Icon(Icons.adjust),
                    label: Text(lifes.toString()),
                  ),
                )
              ]
            ),
          ]
    );
  }

  onKeepPress(BuildContext context, LongPressMoveUpdateDetails details) {
    RenderBox getBox = context.findRenderObject();
    if(flag){
      flag = false;
      double startPosX = getBox.globalToLocal(details.globalPosition).dx - 75;
      double startPosY = getBox.globalToLocal(details.globalPosition).dy - 75;
      startAngle = getAngle(startPosX, startPosY);
      setState(() {
        angle += deltaAngle;
        deltaAngle = 0;
      });
    }
    else {
      double posX = getBox.globalToLocal(details.globalPosition).dx - 75;
      double posY = getBox.globalToLocal(details.globalPosition).dy - 75;
      setState(() {
        deltaAngle = getAngle(posX, posY) - startAngle;
      });
    }
  }

  double getAngle(double x, double y){
    if (x > 0)
      return atan(y/x);
    else
      return atan(y/x) + pi;
  }

  bool checkAngle() {
    if ((angle + deltaAngle).abs() % (2*pi) < 0.15 || (angle + deltaAngle).abs() % (2*pi) > 2*pi - 0.15)
      return false;
    return true;
  }
}
