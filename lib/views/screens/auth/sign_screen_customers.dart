// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../colors_app.dart';
import 'sign_in_costomer.dart';

class SignScreenCustomers extends StatelessWidget {
  const SignScreenCustomers({super.key});

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
              Navigator.pushNamed(context, 'SignUpCustomers');
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 60),
                elevation: 10,
                backgroundColor: Colors.redAccent),
            child: Text(
              'Create an account',
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
              Navigator.pushNamed(context, 'SignInCustomers');
            },
            style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 60),
                elevation: 10,
                backgroundColor: Color.fromARGB(255, 159, 159, 159)),
            child: Text(
              'Login',
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
