// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePageButton extends StatelessWidget {
  final String text;
  final void Function() route;

  const HomePageButton({
    required this.text,
    required this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      // height: MediaQuery.of(context).size.height * 0.07,
      child: ElevatedButton(
          onPressed: route,
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(238, 231, 215, 0.9),
                fontSize: 20,
              ),
            ),
          )),
    );
  }
}
