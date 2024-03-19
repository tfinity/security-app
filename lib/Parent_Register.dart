import 'package:flutter/material.dart';

import 'package:secure_me/Login.dart';
import 'package:secure_me/Widgets/Components/custom_secondarybutton.dart';

import 'Utilities/constants.dart';
import 'Widgets/Components/custom_primarybutton.dart';
import 'Widgets/Components/custom_textfield.dart';

class ParentRegisterPage extends StatefulWidget {
  ParentRegisterPage({super.key});

  @override
  State<ParentRegisterPage> createState() => _ParentRegisterPageState();
}

class _ParentRegisterPageState extends State<ParentRegisterPage> {
  bool isPasswordShown = true;

  final formkey = GlobalKey<FormState>();

  final formdata = Map<String, Object>();

  onSubmit() {
    formkey.currentState!.save();
   progressIndicator(context);   
    print(formdata["email"]);   // Parent Email  
    print(formdata["cemail"]);  // Child email
    print(formdata["name"]);    // Parent Name  
    print(formdata["number"]);  // Phone Number
    print(formdata["password"]); // Password
    print(formdata["apassword"]); // Retype the password
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
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
                'PARENT REGISTER',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
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
                        hintText: 'Child Email',
                        textInputAction: TextInputAction.next,
                        keyboardtype: TextInputType.emailAddress,
                        onsave: (cemail) {
                          formdata["cemail"] = cemail ?? " ";
                        },
                        isPassword: false,
                        validate: (cemail) {
                          // if (email!.isEmpty ||
                          //     email.length > 5 ||
                          //     email.contains("@")) {
                          //   return "Enter Correct Email";
                          // }
                          if (cemail!.contains("@")) {
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
          ]),
        ),
      ),
    );
  }
}
