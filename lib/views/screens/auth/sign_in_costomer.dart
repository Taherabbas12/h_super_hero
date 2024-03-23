// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:toast/toast.dart';

import '../../../colors_app.dart';
import '../../../paths.dart';

class SignInCustomers extends StatelessWidget {
  SignInCustomers({super.key});
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: primaryColorCo,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              decorationImage(context, 'assets/signin.png'),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xfff0f0f0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 103, 103, 103),
                          blurRadius: 4,
                          offset: Offset(2, 2))
                    ]),
                child: TextField(
                  controller: email,
                  style: const TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      labelStyle: const TextStyle(fontSize: 18),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xfff0f0f0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 103, 103, 103),
                          blurRadius: 4,
                          offset: Offset(2, 2))
                    ]),
                child: TextField(
                  controller: password,
                  style: const TextStyle(fontSize: 18),
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(fontSize: 18),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  if (email.text.isNotEmpty && password.text.isNotEmpty) {
// Create Account Company
                    final dio = Dio();

                    var fromData = FormData.fromMap({
                      'email': email.text.trim(),
                      'password': password.text
                    });

                    Response response = await dio
                        .post(PATHS.authSignInCustomers, data: fromData);
                    print(response.data);
                    Map data = jsonDecode(response.data);
                    print(data);

                    if (data['status'] != 'fail') {
                      print(data);
                      await GetStorage().write('auth', {
                        'id': data['data'][0]['id'],
                        'name': data['data'][0]['name'],
                        'email': email.text.trim(),
                        'gender': data['data'][0]['gender'],
                        'certificate': data['data'][0]['certificate'],
                        'experience': data['data'][0]['experience'],
                        'dataOld': data['data'][0]['dataOld'],
                        'location': data['data'][0]['location'],
                        'typeAuht': 'customers',
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

                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, 'HomeScreen', (route) => false);
                  //Navigator.pushReplacementNamed(context, 'HomeScreen');
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 60),
                    elevation: 10,
                    backgroundColor: const Color(0xffff6363)),
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
      ),
    );
  }
}

Widget decorationImage(context, String url) => Container(
    width: MediaQuery.sizeOf(context).width * 0.9,
    height: MediaQuery.sizeOf(context).width * 0.65,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(fit: BoxFit.cover, image: AssetImage(url))));
