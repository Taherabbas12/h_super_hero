// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../colors_app.dart';
import 'sign_in_costomer.dart';

class SignScreenCompany extends StatelessWidget {
  const SignScreenCompany({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorCo,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
            height: 100,
          ),
          decorationImage(context, 'assets/sign.png'),
          SizedBox(
            height: 150,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'SignUp');
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 60),
                elevation: 10,
                backgroundColor: Colors.redAccent),
            child: Text(
              'انشاء حساب',
              style: TextStyle(
                  fontSize: 30, fontWeight: FontWeight.bold, color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'SignIn');
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 60),
                elevation: 10,
                backgroundColor: Color.fromARGB(255, 159, 159, 159)),
            child: Text(
              'تسجيل دخول',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}
