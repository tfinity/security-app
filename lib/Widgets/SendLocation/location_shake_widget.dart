import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secure_me/Utilities/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationShakeWidget extends StatefulWidget {
  const LocationShakeWidget({super.key});

  @override
  State<LocationShakeWidget> createState() => _LocationShakeWidgetState();
}

class _LocationShakeWidgetState extends State<LocationShakeWidget> {
  Position? _curentPosition;
  String? _curentAddress;
  String guardianPhone = '';
  bool isShakeEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _checkShakeEnabled();
      _loadPhone();
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

  void _loadPhone() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final contacts =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    guardianPhone = contacts.data()?['phone'] ?? '';
    print('guardian: $guardianPhone');
  }

  void _checkShakeEnabled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isShakeEnabled = prefs.getBool('shakeEnabled') ?? false;
    setState(() {});
  }

  Future<void> _changeShakeSettings(
      void Function(void Function()) setState) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(
      () => isShakeEnabled = !isShakeEnabled,
    );
    await prefs.setBool('shakeEnabled', isShakeEnabled);
  }

  @override
  Widget build(BuildContext context) {
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
          if (_curentAddress != null) Text(_curentAddress!),
          ElevatedButton(
            child: Text(isShakeEnabled ? "Disable Shake" : "Enable Shake"),
            onPressed: () async {
              //await getCurrentLocation();
              await _changeShakeSettings(setState);
              setState(() {});
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(
              child: Text("SEND ALERT"),
              onPressed: () async {
                if (!(await _isPermissionGranted())) {
                  Fluttertoast.showToast(msg: "SMS Permission is not enabled");
                  await Permission.sms.request();
                  return;
                }

                print('contact $guardianPhone');
                await sendSms(
                  phoneNumber: guardianPhone,
                  location:
                      "https://www.google.com/maps/search/?api=1&query=${_curentPosition!.latitude}%2C${_curentPosition!.longitude}. $_curentAddress",
                );
              }),
        ],
      ),
    );
  }
}
