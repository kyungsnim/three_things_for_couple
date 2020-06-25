import 'package:flutter/material.dart';
import 'package:threethingsforcouple/constants/constants.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
            text: '가칭: ',
            style: TextStyle(fontSize: 25, color: Colors.blueGrey),
            children: <TextSpan>[
          TextSpan(
            text: '부부의 세개',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: primaryTextColor,
              shadows: [
                Shadow(
                    offset: Offset(0.5, 0.5),
                    color: Colors.black54,
                    blurRadius: 3),
              ],
            ),
          )
        ]));
  }
}
