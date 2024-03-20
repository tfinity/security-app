import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:secure_me/Utilities/services.dart';
import 'package:secure_me/Widgets/home_widgets/Custom_appbar.dart';
import 'package:secure_me/Widgets/home_widgets/Custom_slider.dart';
import 'package:secure_me/Widgets/home_widgets/Emergency.dart';
import 'package:secure_me/Widgets/home_widgets/LiveWidget.dart';
import 'package:secure_me/Widgets/SendLocation/SendLocation.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({super.key});
  int q_index = 1;
  GlobalKey<SendLocationState> _locationState = GlobalKey<SendLocationState>();

  get_random_quote() {
    Random random = Random();

    setState(() {
      q_index = random.nextInt(20);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadContacts();
    _startListeningShake();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 244, 255),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 35, 8, 8),
        child: Column(
          children: [
            custom_appbar(
              quotes_index: q_index,
              onTap: get_random_quote(),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Custom_slider(),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'Emergency Contacts',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Emergency(),
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      'Explore near you',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  LiveWidget(),
                  SendLocation(
                    key: _locationState,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _startListeningShake() async {
    print('shake listen');
    Position? position = await getCurrentLocation();
    ShakeDetector.autoStart(
        shakeThresholdGravity: 2.7,
        shakeSlopTimeMS: 500,
        shakeCountResetTime: 3000,
        minimumShakeCount: 1,
        onPhoneShake: () async {
          print('shaking');
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          final isShakeEnabled = prefs.getBool('shakeEnabled') ?? false;
          if (!isShakeEnabled) {
            return;
          }
          if (ModalRoute.of(context)!.isCurrent) {
            _locationState.currentState!
                .ShowModel(_locationState.currentState!.context);
          }
          final number = await _loadPhone();
          String messageBody =
              "https://www.google.com/maps/search/?api=1&query=${position?.latitude}%2C${position?.longitude}";
          await sendSms(phoneNumber: number, location: messageBody);
        });
  }

  Future<String> _loadPhone() async {
    final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final contacts =
        await FirebaseFirestore.instance.collection('Users').doc(userId).get();
    final guardianPhone = contacts.data()?['phone'] ?? '';
    print('guardian: $guardianPhone');
    return guardianPhone;
  }
}
