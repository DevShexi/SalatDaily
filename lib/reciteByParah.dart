import 'package:flutter/material.dart';
import 'constants.dart';

class ReciteByParah extends StatefulWidget {
  @override
  _ReciteByParahState createState() => _ReciteByParahState();
}

class _ReciteByParahState extends State<ReciteByParah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          'Recite Parah',
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
