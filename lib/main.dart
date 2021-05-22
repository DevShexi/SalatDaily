import 'package:flutter/material.dart';
import 'package:salatdaily/login.dart';
import 'package:salatdaily/home.dart';
import 'package:salatdaily/history.dart';
import 'package:salatdaily/constants.dart';
import 'package:salatdaily/readQUran.dart';
import 'package:salatdaily/reciteBySurah.dart';
import 'package:salatdaily/reciteByParah.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
        '/history': (context) => History(),
        '/readQuran': (context) => ReadQuran(),
        '/surahs': (context) => ReciteBySurah(),
        '/parahs': (context) => ReciteByParah(),
      },
      title: 'Salat Daily',
      theme: ThemeData(
        primaryColor: kTeal,
        accentColor: kTeal,
        primarySwatch: MaterialColor(
          0xff51B991,
          {
            50: Color(0xff51B991),
            100: Color(0xff51B991),
            200: Color(0xff51B991),
            300: Color(0xff51B991),
            400: Color(0xff51B991),
            500: Color(0xff51B991),
            600: Color(0xff51B991),
            700: Color(0xff51B991),
            800: Color(0xff51B991),
            900: Color(0xff51B991),
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //As the default route ie '/' is set to Login() on line 17,
      //therefore, no need to specify the home: attribute of our material app.
      //home: Login(),
    );
  }
}
