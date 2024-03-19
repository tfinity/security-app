import 'package:flutter/material.dart';
import 'package:secure_me/Utilities/constants.dart';

class custom_primarybutton extends StatelessWidget {
  final String title;

  final Function onPressed;
  bool loading;
  custom_primarybutton(
      {required this.title, this.loading = false, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18, color: const Color.fromARGB(255, 255, 248, 232)),
        ),
        style: ElevatedButton.styleFrom(backgroundColor: PrimaryColor),
      ),
    );
  }
}
