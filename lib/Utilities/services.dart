import 'package:background_sms/background_sms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

// List<String> emergencyContacts = [];

Future<bool> sendSms({
  required String phoneNumber,
  required String location,
  int simSlot = 1,
}) async {
  final messageToSend = "I'm in trouble $location";
  SmsStatus result = await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber, message: messageToSend, simSlot: simSlot);
  print('$phoneNumber');
  print('$messageToSend');
  print('status: $result');
  if (result == SmsStatus.sent) {
    Fluttertoast.showToast(msg: "send");
  } else {
    Fluttertoast.showToast(msg: "failed");
  }
  return result == SmsStatus.sent;
}

Future<Position?> getCurrentLocation() async {
  final hasPermission = await _handleLocationPermission();
  if (!hasPermission) return null;
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      forceAndroidLocationManager: true);
}

Future<bool> _handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Fluttertoast.showToast(
        msg: "Location services are disabled. Please enable the services");
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(msg: "Location permissions are denied");

      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(
        msg:
            "Location permissions are permanently denied, we cannot request permissions");

    return false;
  }
  return true;
}

// void loadContacts() async {
//   final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
//   final contacts = await FirebaseFirestore.instance
//       .collection('Users')
//       .doc(userId)
//       .collection('Contacts')
//       .get();
//   emergencyContacts =
//       contacts.docs.map((e) => e.data()['number'] as String).toList();
// }
