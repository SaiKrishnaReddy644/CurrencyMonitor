import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text("SIVISOFT",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  letterSpacing: 3,
                  fontWeight: FontWeight.w500)),
        ),
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text("CURRENCY CONVERTER",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
