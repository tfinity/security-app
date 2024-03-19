import 'package:flutter/material.dart';

class custom_secondarybutton extends StatelessWidget {
  final String title;
  final Function onPressed;
  final Color color;

  const custom_secondarybutton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          title,
          style: TextStyle(fontSize: 15, color: color),
        ),
      ),
    );
  }
}
