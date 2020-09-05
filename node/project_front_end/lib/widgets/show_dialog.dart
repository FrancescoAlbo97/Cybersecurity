import 'package:flutter/material.dart';
import 'package:project_front_end/views/common/token.dart';
import 'package:project_front_end/views/gallery/gallery.dart';
import 'package:project_front_end/views/home/home.dart';

class ShowDialog {
  static void showError(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: <Widget>[
                Text('Sei sicuro di voler eseguire il logout?')
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Annulla", style: TextStyle(color: Colors.blueGrey[300]),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Conferma"),
                onPressed: () {
                  IdRepository.invalidate();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              ),
            ],
          );
        });
  }

  static List<Chip> _getChips(JsonObj element) {
    List<Chip> result = List<Chip>();
    for(int i=0; i < element.measures.length; i++)
      result.add(
          Chip(
              backgroundColor: Colors.blue[100],
              label: Text('${element.measures[i].tag}: ${element.measures[i].confidence.toString()} %', style: TextStyle(fontSize: 12),)
          )
      );
    return result;
  }

  static void showCustomDialog({
    @required BuildContext context,
    @required JsonObj element
  }) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: Text("Dettagli Immagine"),
              content: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 400,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 300,
                              child: Image.network(
                                'https://ipfs.io/ipfs/' + element.hash,
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text('TAGS (Misure)', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
                            ),
                            Wrap(
                                spacing: 8,
                                children: [
                                  ..._getChips(element),
                                ]

                            )
                          ]
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 40),
                      width: 250,
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('IMAGE INFO', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          Text('xResolution: ${element.image.xResolution.toString()}'),
                          Text('yResolution: ${element.image.yResolution.toString()}'),
                          Text('resolutionUnit: ${element.image.resolutionUnit.toString()}'),
                          Text('imageDescription: ${element.image.imageDescription}'),
                          Text('make: ${element.image.make}'),
                          Text('model: ${element.image.model}'),
                          Text('orientation: ${element.image.orientation.toString()}'),
                          Text('software: ${element.image.software}'),
                          Text('modifyDate: ${element.image.modifyDate}'),
                          Text('yCbCrPositioning: ${element.image.yCbCrPositioning.toString()}'),
                          Text('exifOffset: ${element.image.exifOffset.toString()}'),
                          Text('gPSInfo: ${element.image.gPSInfo.toString()}'),
                        ],
                      ),
                    ),
                    Container(
                      width: 250,
                      margin: EdgeInsets.only(left: 40),
                      color: Colors.grey[200],
                      padding: EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('GPS INFO', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                          Text('LatitudeRef: ${element.gps.gPSLatitudeRef}'),
                          Text('Latitude: ${element.gps.gPSLatitude.toString()}'),
                          Text('LongitudeRef: ${element.gps.gPSLongitudeRef}'),
                          Text('Longitude: ${element.gps.gPSLongitude}'),
                          Text('AltitudeRef: ${element.gps.gPSAltitudeRef.toString()}'),
                          Text('Altitude: ${element.gps.gPSAltitude.toStringAsFixed(3)}'),
                          Text('Satellites: ${element.gps.gPSSatellites}'),
                        ],
                      ),
                    ),
                  ]
              ),
              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                FlatButton(
                  child: new Text("Chiudi"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
      );
  }
}
