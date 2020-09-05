import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_front_end/views/common/token.dart';
import 'package:project_front_end/views/home/home.dart';
import 'package:project_front_end/widgets/show_dialog.dart';

class Gallery extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  //List<String> images = ['QmZCb7pfUboPJVjA47Xnckm21bEpJx3AnSNS81HBMBmcJF', 'QmZCb7pfUboPJVjA47Xnckm21bEpJx3AnSNS81HBMBmcJF'];
  List<JsonObj> gallery = List<JsonObj>();
  @override
  void initState() {
    getImage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.white
        ),
        title: Text('Gallery'),
          actions: [
            Padding(
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                color: Colors.white,
                child: Text('Logout', style: TextStyle(color: Colors.blue),),
                onPressed: () => ShowDialog.showError(context)
              ),
            )
          ]
      ),
      body: Column(
        children: [
          LimitedBox(
            maxHeight: MediaQuery.of(context).size.height - 56,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) => Card(
                margin:  EdgeInsets.all(15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Image.network(
                              'https://ipfs.io/ipfs/' + gallery[index].hash,
                          )
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        width: double.infinity,
                        child: FlatButton(
                          color: Colors.blue,
                          child: Text('Dettagli', style: TextStyle(color: Colors.white),),
                          onPressed: () => ShowDialog.showCustomDialog(
                             context: context,
                             element: gallery[index]
                          ),
                        ),
                      )
                    ]
                ),
              ),
              itemCount: gallery.length,
            ),
          ),
        ]
      ),
    );
  }

  void getImage() async {
    String token = await IdRepository.getId();
    final res = await http.get("http://localhost:3000/image/get",
        headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: ("Bearer " + token.substring(1, token.length -1))}
    );

    if (res.statusCode == 200) {
      List jsonObj = json.decode(res.body)['gallery'];
      List<JsonObj>  temp = List<JsonObj>();
      for(int i=0; i < jsonObj.length; i++){
        temp.add(JsonObj.fromJson(jsonObj[i]));
      }
      setState(() {
        gallery = temp;
      });
    }
  }

}

class JsonObj {
  String hash;
  ImageMetadata image;
  Gps gps;
  List<Measures> measures;

  JsonObj(this.hash, this.image, this.gps, [this.measures]);

  factory JsonObj.fromJson(dynamic json) {
    if (json['measures'] != null) {
      var tagObjsJson = json['measures'] as List;
      List<Measures> _measures = tagObjsJson.map((tagJson) => Measures.fromJson(tagJson))
          .toList();

      return JsonObj(
          json['hash'] as String,
          ImageMetadata.fromJson(json['image']),
          Gps.fromJson(json['gps']),
          _measures,
      );
    } else {
      return JsonObj(
          json['hash'] as String,
          ImageMetadata.fromJson(json['image']),
          Gps.fromJson(json['gps']),
      );
    }
  }
  @override
  String toString() {
    return '{ ${this.hash}, ${this.measures}, ${this.image}, ${this.gps} }';
  }
}

class ImageMetadata {
  int xResolution;
  int yResolution;
  int resolutionUnit;
  String imageDescription;
  String make;
  String model;
  int orientation;
  String software;
  String modifyDate;
  int yCbCrPositioning;
  int exifOffset;
  int gPSInfo;

  ImageMetadata(
    this.xResolution,
    this.yResolution,
    this.resolutionUnit,
    this.imageDescription,
    this.make,
    this.model,
    this.orientation,
    this.software,
    this.modifyDate,
    this.yCbCrPositioning,
    this.exifOffset,
    this.gPSInfo,
  );

  factory ImageMetadata.fromJson(dynamic json) {
    return ImageMetadata(
        json['XResolution'] as int,
        json['YResolution'] as int,
        json['ResolutionUnit'] as int,
        json['ImageDescription'] as String,
        json['Make'] as String,
        json['Model'] as String,
        json['Orientation'] as int,
        json['Software'] as String,
        json['ModifyDate'] as String,
        json['YCbCrPositioning'] as int,
        json['ExifOffset'] as int,
        json['GPSInfo'] as int,
    );
  }
}

class Gps {
  String gPSLatitudeRef;
  String gPSLongitudeRef;
  double gPSAltitudeRef;
  double gPSAltitude;
  String gPSSatellites;
  List<dynamic> gPSLatitude;
  List<dynamic> gPSLongitude;

  Gps(
    this.gPSLatitudeRef,
    this.gPSLongitudeRef,
    this.gPSAltitudeRef,
    this.gPSAltitude,
    this.gPSSatellites,
    [this.gPSLatitude,
     this.gPSLongitude,]
  );

  factory Gps.fromJson(dynamic json) {
    return Gps(
      json['GPSLatitudeRef'] as String,
      json['GPSLongitudeRef'] as String,
      json['GPSAltitudeRef'] as double,
      json['GPSAltitude'] as double,
      json['GPSSatellites'] as String,
      json['GPSLatitude'] as List<dynamic>,
      json['GPSLongitude'] as List<dynamic>,
    );
  }

}

class Measures {
  int confidence;
  String tag;

  Measures(this.confidence, this.tag);

  factory Measures.fromJson(dynamic json) {
    return Measures(json['confidence'] as int, json['tag'] as String);
  }
}

