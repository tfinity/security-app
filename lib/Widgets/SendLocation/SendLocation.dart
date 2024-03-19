import 'package:background_sms/background_sms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secure_me/Utilities/services.dart';

class SendLocation extends StatefulWidget {
  const SendLocation({super.key});

  @override
  State<SendLocation> createState() => SendLocationState();
}

class SendLocationState extends State<SendLocation> {
  Position? _curentPosition;
  String? _curentAddress;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _curentPosition = await getCurrentLocation();
      await _getAddressFromLatLon();
    });
  }

  Future<bool> _isPermissionGranted() async =>
      await Permission.sms.status.isGranted;

  Future<void> _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
            "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void ShowModel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SEND YOUR CUURENT LOCATION",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 10),
              if (_curentPosition != null) Text(_curentAddress!),
              ElevatedButton(
                  child: Text("GET LOCATION"),
                  onPressed: () async {
                    await getCurrentLocation();
                  }),
              SizedBox(height: 10),
              ElevatedButton(
                  child: Text("SEND ALERT"),
                  onPressed: () async {
                    if (!(await _isPermissionGranted())) {
                      Fluttertoast.showToast(
                          msg: "SMS Permission is not enabled");
                      await Permission.sms.request();
                      return;
                    }
                    for (var contact in emergencyContacts) {
                      print('contact $contact');
                      await sendSms(
                        phoneNumber: contact,
                        location:
                            "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress",
                      );
                    }
                    // String recipients = "";
                    // List<TContact> contactList =
                    //     await DatabaseHelper().getContactList();
                    // print(contactList.length);
                    // if (contactList.isEmpty) {
                    //   Fluttertoast.showToast(msg: "emergency contact is empty");
                    // } else {
                    //   String messageBody =
                    //       "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress";

                    //   if (await _isPermissionGranted()) {
                    //     contactList.forEach((element) {
                    //       _sendSms("${element.number}",
                    //           "i am in trouble $messageBody");
                    //     });
                    //   } else {
                    //     Fluttertoast.showToast(msg: "something wrong");
                    //   }
                    // }
                  }),
            ],
          ),
        );
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
