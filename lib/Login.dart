import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_me/Home_Screen.dart';
import 'package:secure_me/Parent_Register.dart';
import 'package:secure_me/User_Register.dart';
import 'package:secure_me/Utilities/constants.dart';
import 'package:secure_me/Widgets/Components/custom_primarybutton.dart';
import 'package:secure_me/Widgets/Components/custom_textfield.dart';

import 'Widgets/Components/custom_secondarybutton.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isPasswordShown = true;
  final formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController(),
      password = TextEditingController();
  bool isLoading = false;

  _toggleLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  onSubmit() async {
    formkey.currentState!.save();
    try {
      _toggleLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      print('credentials: $credential');
      _navigateToHome();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        Alert_Message(context, 'Please Check Your Credentials');
        print(e.code);
      }
    }
    print(email.text);
    print(password.text);
    _toggleLoading();
  }

  _navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  isLoading
                      ? progressIndicator(context)
                      : Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Image.asset(
                                'assets/iit_logo.png',
                                height: 100,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 50.0, bottom: 50),
                              child: Text(
                                'USER LOGIN',
                                style: TextStyle(
                                    fontSize: 35, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: CustomTextField(
                                      hintText: 'Login',
                                      controller: email,
                                      textInputAction: TextInputAction.next,
                                      keyboardtype: TextInputType.emailAddress,
                                      isPassword: false,
                                      validate: (email) {
                                        // if (email!.isEmpty ||
                                        //     email.length > 5 ||
                                        //     email.contains("@")) {
                                        //   return "Enter Correct Email";
                                        // }
                                        if (email!.contains("@")) {
                                          return null;
                                        }
                                        return "Enter Correct Email";
                                      },
                                      prefix: Icon(Icons.person),
                                      suffix: Icon(Icons.person),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: CustomTextField(
                                      hintText: 'Password',
                                      controller: password,
                                      validate: (password) {
                                        if (password!.length > 6) {
                                          return null;
                                        }
                                        return "Enter Correct Password";
                                      },
                                      isPassword: isPasswordShown,
                                      prefix: Icon(Icons.lock),
                                      suffix: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPasswordShown = !isPasswordShown;
                                          });
                                        },
                                        icon: isPasswordShown
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: custom_primarybutton(
                                title: 'LOGIN',
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    onSubmit();
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  custom_secondarybutton(
                                    title: 'User Register',
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UserRegisterPage(),
                                          ));
                                    },
                                    color: PrimaryColor,
                                  ),
                                  custom_secondarybutton(
                                    title: 'Forgot Password?',
                                    onPressed: () {},
                                    color: Colors.blueAccent,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  custom_secondarybutton(
                                    title: 'Parent Register',
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ParentRegisterPage(),
                                          ));
                                    },
                                    color: PrimaryColor,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
