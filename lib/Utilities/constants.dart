import 'package:flutter/material.dart';

// lightish pink wala color
Color PrimaryColor = Color.fromARGB(255, 136, 69, 121);

// Custom navigator
void GoTo(BuildContext context, Widget nextPage) {
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => nextPage,
      ));
}

// Custom Progress Indicator
Widget progressIndicator(BuildContext context) {
  return Center(
      child: CircularProgressIndicator(
    backgroundColor: PrimaryColor,
    color: Color.fromARGB(255, 166, 106, 153),
    strokeWidth: 6,
  ));
}

// Custom On screen message
Alert_Message(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(text),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.zero)),
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
                fontStyle: FontStyle.normal, color: Colors.black, fontSize: 20),
          ));
}
