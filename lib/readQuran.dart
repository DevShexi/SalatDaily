import 'package:flutter/material.dart';
import 'constants.dart';

class ReadQuran extends StatefulWidget {
  @override
  _ReadQuranState createState() => _ReadQuranState();
}

class _ReadQuranState extends State<ReadQuran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'القرآن الکریم',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            _card('/surahs'),
            SizedBox(
              height: 20,
            ),
            _card('/parahs'),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _card(String route) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kLight,
          ),
          child: Column(
            children: [Icon(Icons.inbox), Text("Surahs")],
          ),
        ),
      ),
    );
  }
}
