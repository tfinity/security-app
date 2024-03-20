import 'package:background_sms/background_sms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secure_me/Utilities/services.dart';
import 'package:secure_me/Widgets/SendLocation/location_shake_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SendLocation extends StatefulWidget {
  const SendLocation({super.key});

  @override
  State<SendLocation> createState() => SendLocationState();
}

class SendLocationState extends State<SendLocation> {
  void ShowModel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return LocationShakeWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => ShowModel(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Send Location',
                        style: TextStyle(fontSize: 25),
                      ),
                      subtitle: Text('Share You Location'),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                  child: Image.asset(
                'assets/map.png',
                height: 150,
                width: 150,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
