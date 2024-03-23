// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:h_super_hero/colors_app.dart';
import 'package:h_super_hero/paths.dart';
import 'package:toast/toast.dart';

import '../../widgets/text_input.dart';
import 'sign_up_customers.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController describtion = TextEditingController();

  TextEditingController rePassword = TextEditingController();
  String location = 'Choose Loaction';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorCo,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 10),
              textInput2(userName, 'Company Name'),
              const SizedBox(height: 10),
              textInput2(email, 'Company Email'),
              const SizedBox(height: 10),
              textInput2(describtion, 'Company describtion'),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: 60,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 118, 118, 118)),
                    borderRadius: BorderRadius.circular(15),
                    color: inputColor,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 103, 103, 103),
                          blurRadius: 4,
                          offset: Offset(2, 2))
                    ]),
                child: DropdownButton(
                  underline: const SizedBox(),
                  dropdownColor: inputColor,
                  items: locationData
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ))
                      .toList(),
                  onChanged: (String? v) {
                    location = v!;
                    setState(() {});
                  },
                  value: location,
                ),
              ),
              const SizedBox(height: 50),
              textInput2(password, 'Password'),
              const SizedBox(height: 10),
              textInput2(rePassword, 'Re Password'),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  if (userName.text.isNotEmpty &&
                      email.text.isNotEmpty &&
                      password.text.isNotEmpty &&
                      rePassword.text.isNotEmpty) {
                    if (password.text == rePassword.text &&
                        password.text.length > 7) {
                      // Create Account Company
                      final dio = Dio();

                      var fromData = FormData.fromMap({
                        'name': userName.text.trim(),
                        'email': email.text.trim(),
                        'password': password.text,
                        'describtion': describtion.text,
                        'location': location,
                      });

                      Response response = await dio
                          .post(PATHS.authSignUpCompany, data: fromData);
                      Map data = jsonDecode(response.data);
                      print(data);
                      if (data['status'] != 'fail') {
                        await GetStorage().write('auth', {
                          'name': userName.text.trim(),
                          'email': email.text.trim(),
                          'location': location,
                          'describtion': describtion.text,
                          'typeAuht': 'Company',
                        });

                        Navigator.pushNamedAndRemoveUntil(
                            context, 'HomeScreen', (route) => false);
                      } else {
                        ToastContext().init(context);
                        Toast.show(data['message'],
                            duration: 3,
                            gravity: Toast.bottom,
                            backgroundColor: Colors.red);
                        //  if(response.data)
                      }
                    } else {
                      ToastContext().init(context);
                      Toast.show("يجب ان يكون الرمز متساوي واكبر من 8 ",
                          duration: 3,
                          gravity: Toast.bottom,
                          backgroundColor: Colors.red);
                    }
                  } else {
                    ToastContext().init(context);
                    Toast.show("يرجى ملأ كل الحقول",
                        duration: 3,
                        gravity: Toast.bottom,
                        backgroundColor: Colors.red);
                  }
                },
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 60),
                    elevation: 10,
                    backgroundColor: const Color(0xff008d5d)),
                child: const Text(
                  'Create an account',
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
