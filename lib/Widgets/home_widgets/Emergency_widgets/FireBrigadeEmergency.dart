import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class FireBrigadeEmergency extends StatelessWidget {
  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5, top: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap:() => _callNumber('101'),
          child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 153, 143, 255),
                  Color.fromARGB(255, 182, 178, 255),
                  Color.fromARGB(255, 213, 206, 255),
                  Color.fromARGB(255, 214, 206, 255),
                  Color.fromARGB(255, 182, 178, 255),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
        
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.5),
                    child: Image.asset('assets/fire.png'),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fire Brigade',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 0.8, // shadow blur
                                color: Colors.black, // shadow color
                                offset:
                                    Offset(0.05, 0.05), // how much shadow will be shown
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Call 101 for fire emergency',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            shadows: [
                              Shadow(
                                blurRadius: 0.8, // shadow blur
                                color: Colors.black, // shadow color
                                offset:
                                    Offset(0.05, 0.05), // how much shadow will be shown
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 80,
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: Text('1 0 1',
                            style: TextStyle(color: Colors.red[500],
                              fontSize: MediaQuery.of(context).size.width * 0.04,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 0.8, // shadow blur
                                  color: Colors.black, // shadow color
                                  offset:
                                      Offset(0.05, 0.05), // how much shadow will be shown
                                ),
                              ],),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        
      ),
    );
  }
}
