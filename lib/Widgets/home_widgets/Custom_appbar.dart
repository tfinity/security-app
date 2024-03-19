import 'package:flutter/material.dart';
import 'package:secure_me/Utilities/iit_quotes.dart';

class custom_appbar extends StatelessWidget {
  // const custom_appbar({super.key});
  Function? onTap;
  int? quotes_index;
  custom_appbar({this.onTap, this.quotes_index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap ?? ();
      },
      child: Container(
        child: Text(
          quotes[quotes_index!],
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,

          // style: GoogleFonts.getFont('Lato'),
        ),
      ),
    );
  }
}
