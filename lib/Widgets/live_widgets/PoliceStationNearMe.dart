import 'package:flutter/material.dart';

class PoliceStationNearMe extends StatelessWidget {
  final Function? onMapFunction;
  const PoliceStationNearMe({super.key, this.onMapFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onMapFunction!('police stations near me'); 
          },
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 50,
              width: 50,
              child: Center(
                child: Image.asset(
                  'assets/policestation.png',
                  height: 35,
                ),
              ),
            ),
          ),
        ),
        Text('Police')
      ],
    );
  }
}
