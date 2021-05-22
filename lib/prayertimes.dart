import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class PrayerTimes {
  double latitude;
  double longitude;
  List times = [];
  String weekday = '';
  String date = '';
  String month = '';
  String year = '';
  String islamicDate = '';
  String islamicMonth = '';
  String hijriyear = '';

  Future<void> getCurrentLocation() async {
    try {
      Position position =
          await getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      // print(latitude);
      longitude = position.longitude;
      // print(longitude);
    } catch (e) {
      print('Exception Caught: $e');
    }
  }

  Future getPrayerTimes(
      double lat, double lon, int index, String mn, String yr) async {
    String url =
        'http://api.aladhan.com/v1/calendar?latitude=$lat&longitude=$lon&method=1&month=$mn&year=$yr';
    try {
      http.Response response = await http.get(url);
      String prayerTimesResponse = response.body;
      var decodeData = jsonDecode(prayerTimesResponse);
      List data = decodeData['data'];
      times.add(
        (DateFormat.jm().format(
          DateFormat("hh:mm")
              .parse('${data[index]['timings']['Fajr'].split(' ')[0]}'),
        )),
      );
      times.add(
        (DateFormat.jm().format(
          DateFormat("hh:mm")
              .parse('${data[index]['timings']['Sunrise'].split(' ')[0]}'),
        )),
      );
      times.add(
        (DateFormat.jm().format(
          DateFormat("hh:mm")
              .parse('${data[index]['timings']['Dhuhr'].split(' ')[0]}'),
        )),
      );

      times.add(
        (DateFormat.jm().format(
          DateFormat("hh:mm")
              .parse('${data[index]['timings']['Asr'].split(' ')[0]}'),
        )),
      );
      times.add((DateFormat.jm().format(
        DateFormat("hh:mm")
            .parse('${data[index]['timings']['Maghrib'].split(' ')[0]}'),
      )));

      times.add(
        (DateFormat.jm().format(
          DateFormat("hh:mm")
              .parse('${data[index]['timings']['Isha'].split(' ')[0]}'),
        )),
      );

      weekday = data[index]['date']['gregorian']['weekday']['en'];
      islamicDate = data[index]['date']['hijri']['day'];
      islamicMonth = data[index]['date']['hijri']['month']['ar'];
      hijriyear = data[index]['date']['hijri']['year'];
      date = data[index]['date']['gregorian']['day'];
      month = data[index]['date']['gregorian']['month']['en'];
      year = data[index]['date']['gregorian']['year'];
    } catch (e) {
      print('Exception Caught while fetching Prayer Times: $e');
    }
  }

  int nextPrayer() {
    List _timeOfDay = [];
    times.forEach(
      (element) {
        element.split(':')[1].split(' ')[1] == 'PM'
            ? _timeOfDay.add(
                TimeOfDay(
                  hour: (int.parse(element.split(':')[0]) + 12),
                  minute: int.parse(element.split(':')[1].split(' ')[0]),
                ),
              )
            : _timeOfDay.add(
                TimeOfDay(
                  hour: int.parse(element.split(':')[0]),
                  minute: int.parse(element.split(':')[1].split(' ')[0]),
                ),
              );
      },
    );

    int ind = 0;
    _timeOfDay.forEach((element) {
      print('${TimeOfDay.now().hour}');
      print('${element.hour}');
      if (TimeOfDay.now().hour < element.hour) {
        print(ind);
        ind++;
      } else if (TimeOfDay.now().hour == element.hour &&
          TimeOfDay.now().minute < element.minute) {
        print(ind);
        ind++;
      }
    });
    if (TimeOfDay.now().hour > _timeOfDay[5].hour) {
      ind = 6;
    }
    print('Indicater is: $ind');
    return times.length - ind;
  }
}
