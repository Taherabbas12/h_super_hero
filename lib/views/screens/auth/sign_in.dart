// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:h_super_hero/colors_app.dart';
import 'package:toast/toast.dart';

import '../../../paths.dart';
import '../../widgets/text_input.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: primaryColorCo,
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                width: MediaQuery.sizeOf(context).width * 0.95,
                height: (MediaQuery.sizeOf(context).width * 0.9) * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 0.1,
                          color: Color.fromARGB(255, 177, 177, 177),
                          offset: Offset(2, 2))
                    ],
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/signin.png')))),
            const SizedBox(height: 40),
            textInput2(email, 'Email'),
            const SizedBox(height: 20),
            textInput2(password, 'Password', passsword: true),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                if (email.text.isNotEmpty && password.text.isNotEmpty) {
                  // Create Account Company
                  final dio = Dio();

                  var fromData = FormData.fromMap(
                      {'email': email.text.trim(), 'password': password.text});

                  Response response =
                      await dio.post(PATHS.authSignInCompany, data: fromData);
                  print(response.data);
                  Map data = jsonDecode(response.data);
                  print(data);

                  if (data['status'] != 'fail') {
                    await GetStorage().write('auth', {
                      'id': data['data'][0]['id'],
                      'name': data['data'][0]['name'],
                      'email': email.text.trim(),
                      'location': data['data'][0]['location'],
                      'describtion': data['data'][0]['describtion'],
                      'typeAuht': 'Company',
                    });
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'HomeScreen', (route) => false);
                  } else {
                    ToastContext().init(context);
                    Toast.show('Please enter the data correctly',
                        duration: 3,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.red);
                    //  if(response.data)
                  }
                } else {
                  ToastContext().init(context);
                  Toast.show("Please fill out all fields",
                      duration: 3,
                      gravity: Toast.bottom,
                      backgroundColor: Colors.red);
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 60),
                  elevation: 5,
                  backgroundColor: const Color.fromARGB(255, 235, 81, 81)),
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
