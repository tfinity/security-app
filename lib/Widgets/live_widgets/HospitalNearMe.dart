import 'package:flutter/material.dart';

class HospitalNearMe extends StatelessWidget {
  final Function? onMapFunction;
  const HospitalNearMe({super.key, this.onMapFunction});
@override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0,right: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
            onMapFunction!('hospital near me'); 
          },
            child: Card(
              elevation: 3,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Image.asset('assets/hospital.png',height: 35,),
                ),
              ),
            ),
          ),
          Text('Hospital')
        ],
      ),
    );
  }
}