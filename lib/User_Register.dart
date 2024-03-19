import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:secure_me/Login.dart';
import 'package:secure_me/Parent_Register.dart';
import 'package:secure_me/User%20Model/User_Model.dart';
import 'package:secure_me/Widgets/Components/custom_secondarybutton.dart';

import 'Utilities/constants.dart';
import 'Widgets/Components/custom_primarybutton.dart';
import 'Widgets/Components/custom_textfield.dart';

class UserRegisterPage extends StatefulWidget {
  UserRegisterPage({super.key});

  @override
  State<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends State<UserRegisterPage> {
  bool isPasswordShown = true;

  final formkey = GlobalKey<FormState>();

  final formdata = Map<String, Object>();

  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  onSubmit() {
    formkey.currentState!.save();
    _toggleLoading();
    if (formdata['password'] != formdata['apassword']) {
      Alert_Message(context, 'Passwords Do Not Match');
    } else {
      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        auth
            .createUserWithEmailAndPassword(
                email: formdata['email'].toString(),
                password: formdata['password'].toString())
            .then((v) async {
          DocumentReference<Map<String, dynamic>> db =
              FirebaseFirestore.instance.collection('Users').doc(v.user!.uid);
          final user = UserModel(
              name: formdata['name'].toString(),
              phone: formdata['number'].toString(),
              ParentEmail: formdata["gemail"].toString(),
              ChildEmail: formdata["email"].toString(),
              Identity: v.user!.uid);
          final JsonData = user.toJson();
          await db.set(JsonData).whenComplete(() {
            GoTo(context, Login());
          });
        });
      } on FirebaseAuthException catch (e) {
        Alert_Message(context, e.toString());
      } catch (e) {
        Alert_Message(context, e.toString());
      }
    }
    print(formdata["email"]); // Email
    print(formdata["gemail"]); // Guardian Email
    print(formdata["name"]); // Name
    print(formdata["number"]); // Number
    print(formdata["password"]); // Password
    print(formdata["apassword"]); // Retyped Password
    _toggleLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Image.asset(
                      'assets/iit_logo.png',
                      height: 100,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, bottom: 50),
                    child: Text(
                      'USER REGISTER',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Form(
                    key: formkey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // name
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: CustomTextField(
                              hintText: 'Name',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.name,
                              onsave: (name) {
                                formdata["name"] = name ?? " ";
                              },
                              isPassword: false,
                              validate: (name) {
                                // if (email!.isEmpty ||
                                //     email.length > 5 ||
                                //     email.contains("@")) {
                                //   return "Enter Correct Email";
                                // }
                                if (name!.isEmpty) {
                                  return "Enter Your Name";
                                }
                                return null;
                              },
                              prefix: Icon(Icons.person),
                              suffix: Icon(Icons.person),
                            ),
                          ),

                          // phone number
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: CustomTextField(
                              hintText: 'Number',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.number,
                              onsave: (number) {
                                formdata["number"] = number ?? " ";
                              },
                              isPassword: false,
                              validate: (number) {
                                // if (email!.isEmpty ||
                                //     email.length > 5 ||
                                //     email.contains("@")) {
                                //   return "Enter Correct Email";
                                // }
                                if (number!.length < 10) {
                                  return "Enter correct Number";
                                }
                                return null;
                              },
                              prefix: Icon(Icons.phone),
                              suffix: Icon(Icons.phone),
                            ),
                          ),

                          // User Email ID
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: CustomTextField(
                              hintText: 'Email',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              onsave: (email) {
                                formdata["email"] = email ?? " ";
                              },
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
                              prefix: Icon(Icons.email),
                              suffix: Icon(Icons.email),
                            ),
                          ),

                          //  Guardian Email
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: CustomTextField(
                              hintText: 'Guardian Email',
                              textInputAction: TextInputAction.next,
                              keyboardtype: TextInputType.emailAddress,
                              onsave: (gemail) {
                                formdata["gemail"] = gemail ?? " ";
                              },
                              isPassword: false,
                              validate: (gemail) {
                                // if (email!.isEmpty ||
                                //     email.length > 5 ||
                                //     email.contains("@")) {
                                //   return "Enter Correct Email";
                                // }
                                if (gemail!.contains("@")) {
                                  return null;
                                }
                                return "Enter Correct Email";
                              },
                              prefix: Icon(Icons.email),
                              suffix: Icon(Icons.email),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: CustomTextField(
                              hintText: 'Password',
                              onsave: (password) {
                                formdata["password"] = password ?? " ";
                              },
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
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: CustomTextField(
                              hintText: 'Password Again',
                              onsave: (apassword) {
                                formdata["apassword"] = apassword ?? " ";
                              },
                              validate: (apassword) {
                                if (apassword!.length > 6) {
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
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: custom_primarybutton(
                        title: 'REGISTER',
                        onPressed: () {
                          progressIndicator(context);
                          if (formkey.currentState!.validate()) {
                            onSubmit();
                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        custom_secondarybutton(
                          title: 'Register as a Parent',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParentRegisterPage(),
                                ));
                          },
                          color: PrimaryColor,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        custom_secondarybutton(
                          title: 'Login',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ));
                          },
                          color: PrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (_isLoading)
                Positioned.fill(
                  child: Container(
                    color: Colors.black45,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
