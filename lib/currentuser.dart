import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:salatdaily/constants.dart';

class CurrentUser {
  bool myturn;
  List surahName = [];
  List verses = [];
  List verseNumber = [];
  List parahNumber = [];
  List translations = [];

  //presentation details
  String firstName;
  String lastName;
  String date;
  String prayerTime;
  String prayerName;
  String status; //read / unread

  Future<bool> read() async {
    final String statusUpdateUrl = '$kBaseUrl/api/v1/update-status';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('jwt');
    try {
      final http.Response response = await http.put(
        statusUpdateUrl,
        headers: {HttpHeaders.authorizationHeader: 'T ${jwtToken}'},
        body: <String, String>{'status_id': 'read'},
      );
      if (response.statusCode == 200) {
        print('Recitation Status has been Updated successfully: Status = READ');
        return true;
      } else {
        print('Recitation Status Update Failed');
        return false;
      }
    } catch (e) {
      print('Exception Caused while updating Status: $e');
      return false;
    }
  }

  Future<bool> skipTurn() async {
    final String statusUpdateUrl = '$kBaseUrl/api/v1/update-status';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('jwt');
    try {
      final http.Response response = await http.put(
        statusUpdateUrl,
        headers: {HttpHeaders.authorizationHeader: 'T ${jwtToken}'},
        body: <String, String>{'status_id': 'skip'},
      );
      if (response.statusCode == 200) {
        print('Recitation Status Skipped');
        return true;
      } else {
        print('Recitation Status Update Failed');
        return false;
      }
    } catch (e) {
      print('Exception Caused while updating Status: $e');
      return false;
    }
  }

  Future getCurrentUser() async {
    String url = '$kBaseUrl/api/v1/user-schedule';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jwtToken = prefs.getString('jwt');
    http.Response response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: 'T ${jwtToken}'},
    );
    String currentUserResponse = response.body;
    //print(currentUserResponse.runtimeType);
    var decodeData = json.decode(currentUserResponse);
    try {
      myturn = decodeData['schedule-verse']['active_button'];
      firstName = decodeData['schedule-verse']['first_name'];
      lastName = decodeData['schedule-verse']['last_name'];
      date = decodeData['schedule-verse']['prayer_date'];
      prayerName = decodeData['schedule-verse']['prayer_name'];
      prayerTime = (DateFormat.jm().format(
        DateFormat("hh:mm").parse(
            '${decodeData['schedule-verse']['prayer_time'].split(' ')[0]}'),
      ));
      //decodeData['schedule-verse']['prayer_time'];
      List ayats = decodeData['schedule-verse']['surah_verse'];
      ayats.forEach((element) {
        verses.add(element['verse']);
        surahName.add(element['surah_name']);
        verseNumber.add(element['verse_num']);
        parahNumber.add(element['parah_num']);
        translations.add(element['translation']);
      });
      status = decodeData['schedule-verse']['status_id'];
    } catch (e) {
      print('Exception while Decoding CurrentUserResponse: $e');
    }
  }
}
