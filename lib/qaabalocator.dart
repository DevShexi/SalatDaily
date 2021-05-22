import 'package:flutter/material.dart';
import 'dart:async';
import 'package:compasstools/compasstools.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:salatdaily/constants.dart';
import 'package:flutter/services.dart';

class QiblaCompass extends StatefulWidget {
  @override
  _QiblaCompassState createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  int direction;
  int difference;
  bool isloaded = false;
  int _haveSensor;
  String sensorType;
  @override
  void initState() {
    super.initState();
    checkDeviceSensors();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position.latitude);
      print(position.longitude);
      String url =
          'http://api.aladhan.com/v1/qibla/${position.latitude}/${position.longitude}';
      http.Response response = await http.get(url);
      String data = response.body;
      var decodeData = jsonDecode(data);
      setState(() {
        direction = decodeData['data']['direction'].round();
        difference = 360 - direction;
        isloaded = true;
        print(direction);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> checkDeviceSensors() async {
    int haveSensor;

    try {
      haveSensor = await Compasstools.checkSensors;

      switch (haveSensor) {
        case 0:
          {
            // statements;
            sensorType = "No sensors for Compass";
          }
          break;

        case 1:
          {
            //statements;
            sensorType = "Accelerometer + Magnetoneter";
          }
          break;

        case 2:
          {
            //statements;
            sensorType = "Gyroscope";
          }
          break;

        default:
          {
            //statements;
            sensorType = "Error!";
          }
          break;
      }
    } on Exception {}

    if (!mounted) return;

    setState(() {
      _haveSensor = haveSensor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloaded
        ? Scaffold(
            backgroundColor: kLight,
            body: new Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  StreamBuilder(
                    stream: Compasstools.azimuthStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(200)),
                              child: Padding(
                                padding: EdgeInsets.all(20),
                                child: Stack(
                                  children: [
                                    new RotationTransition(
                                      turns: new AlwaysStoppedAnimation(
                                          (-snapshot.data / 360)),
                                      child: Image.asset(
                                        "images/compass.png",
                                      ),
                                    ),
                                    new RotationTransition(
                                      turns: new AlwaysStoppedAnimation(
                                          (-snapshot.data - difference) / 360),
                                      child: Image.asset(
                                        "images/qaaba.png",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Center(
                              child: qabaAngle(snapshot.data),
                              // child: Text(
                              //   '${snapshot.data - direction}\u00B0',
                              //   style: TextStyle(fontSize: 30),
                              // ),
                            ),
                          ],
                        );
                      } else
                        return Text("Error in stream");
                    },
                  ),
                  // Text("SensorType: $sensorType"),
                ],
              ),
            ),
          )
        : Loading();
  }

  qabaAngle(int val) {
    if (val - direction >= -2 && val - direction <= 2) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Card(
          color: kTeal,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Qaaba',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.arrow_upward,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (val - direction > 2 && val - direction < 180) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Card(
          color: kGrey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${val - direction}\u00B0 Anti-Clockwise',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.rotate_left,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (val - direction < -2 && val - direction > -175) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Card(
          color: kGrey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${val - direction}\u00B0 Clockwise',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.rotate_right,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (val - direction < -185 && val - direction > -270) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Card(
          color: kGrey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rotate',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.screen_rotation,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
    }
    if (val - direction >= -185 && val - direction <= -175) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
        ),
        child: Card(
          color: kGrey,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Rotate 180\u00B0',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(width: 20),
                Icon(
                  Icons.screen_rotation,
                  size: 24,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  static const spinkit = SpinKitFadingCircle(
    color: kTeal,
    size: 50.0,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: spinkit,
      ),
    );
  }
}
