import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secure_me/Widgets/live_widgets/PoliceStationNearMe.dart';
import 'package:secure_me/Widgets/live_widgets/PetrolStationNearMe.dart';
import 'package:secure_me/Widgets/live_widgets/GarageNearMe.dart';
import 'package:secure_me/Widgets/live_widgets/HospitalNearMe.dart';
import 'package:secure_me/Widgets/live_widgets/HotelNearMe.dart';
import 'package:secure_me/Widgets/live_widgets/PharmacyNearMe.dart';
import 'package:secure_me/Widgets/live_widgets/GroceryStoreNearMe.dart';
import 'package:secure_me/Widgets/live_widgets/BusStopNearMe.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveWidget extends StatelessWidget {
  const LiveWidget({super.key});

  static Future<void> open_map(String location) async {
    String google_url = 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(google_url);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(msg: "Error aya bhai");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            
            GarageNearMe(onMapFunction: open_map),
            HospitalNearMe(onMapFunction: open_map),
            HotelNearMe(onMapFunction: open_map),
            PharmacyNearMe(onMapFunction: open_map),
            GroceryStoreNearMe(onMapFunction: open_map),
            BusStopNearMe(onMapFunction: open_map),
            PoliceStationNearMe(onMapFunction: open_map),
            PetrolStationNearMe(onMapFunction: open_map)
          ],
        ),
      ),
    );
  }
}
