import 'package:flutter/material.dart';
import 'constants.dart';

class ReciteBySurah extends StatefulWidget {
  @override
  _ReciteBySurahState createState() => _ReciteBySurahState();
}

class _ReciteBySurahState extends State<ReciteBySurah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Recite Surah',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: kSecondLight,
            ),
          ),
          Expanded(
            child: Container(
              color: kThirdLight,
            ),
          )
        ],
      ),
    );
  }
}
