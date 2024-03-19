import 'package:flutter/material.dart';
import 'Emergency_widgets/PoliceEmergency.dart';
import 'Emergency_widgets/WomenEmergency.dart';
import 'Emergency_widgets/FireBrigadeEmergency.dart';
import 'Emergency_widgets/AmbulanceEmergency.dart';
import 'Emergency_widgets/DisasterEmergency.dart';
import 'Emergency_widgets/NationalEmergency.dart';


class Emergency extends StatelessWidget {
  const Emergency({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          WomenEmergency(),
          FireBrigadeEmergency(),
          AmbulanceEmergency(),
          DisasterEmergency(),
          NationalEmergency()


        ],
      ),
    );
  }
}