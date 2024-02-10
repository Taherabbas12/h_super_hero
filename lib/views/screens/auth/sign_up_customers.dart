// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:h_super_hero/paths.dart';
import 'package:toast/toast.dart';

import '../../../colors_app.dart';
import '../../widgets/text_input.dart';

class SignUpCustomers extends StatefulWidget {
  SignUpCustomers({super.key});

  @override
  State<SignUpCustomers> createState() => _SignUpCustomersState();
}

List<String> locationData = [
  'Choose Loaction',
  'Babil',
  'Al-Anbar',
  'Baghdad',
  'Basra',
  'Dhi Qar',
  'Al-Qādisiyyah',
  'Diyala',
  'Duhok',
  'Erbil',
  'Karbala',
  'Kirkuk',
  'Maysan',
  'Muthanna',
  'Najaf',
  'Ninawa',
  'Salah Al-Din',
  'Sulaymaniyah',
  'Wasit',
];

class _SignUpCustomersState extends State<SignUpCustomers> {
  TextEditingController userName = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController certificate = TextEditingController();

  TextEditingController rePassword = TextEditingController();

  TextEditingController experience = TextEditingController();

  String gender = 'Choose gender';
  String location = 'Choose Loaction';

  DateTime dateTime = DateTime(2002);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorCo,
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 40),
            textInput(userName, 'User Name'),
            const SizedBox(height: 20),
            textInput(email, 'Email'),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.5,
                  height: 60,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xfff0f0f0),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 103, 103, 103),
                            blurRadius: 4,
                            offset: Offset(2, 2))
                      ]),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    dropdownColor: Colors.white,
                    items: ['Choose gender', 'Male', 'Female']
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? v) {
                      gender = v!;
                      setState(() {});
                    },
                    value: gender,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        fixedSize:
                            Size(MediaQuery.sizeOf(context).width * 0.33, 60)),
                    onPressed: () async {
                      try {
                        dateTime = (await showDatePicker(
                          context: context,
                          firstDate: DateTime(1960),
                          lastDate: DateTime(2010),
                        ))!;
                        setState(() {});
                      } catch (e) {}
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.date_range_sharp),
                          Text(
                              '${dateTime.year}/${dateTime.month}/${dateTime.day}')
                        ]),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.sizeOf(context).width * 0.9,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xfff0f0f0),
                  boxShadow: const [
                    BoxShadow(
                        color: Color.fromARGB(255, 103, 103, 103),
                        blurRadius: 4,
                        offset: Offset(2, 2))
                  ]),
              child: DropdownButton(
                underline: const SizedBox(),
                dropdownColor: Colors.white,
                items: locationData
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(fontSize: 18),
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
            const SizedBox(height: 20),
            textInput(certificate, 'Certificate'),
            const SizedBox(height: 20),
            textInput(experience, 'Experience'),
            const SizedBox(height: 50),
            textInput(password, 'password', passsword: true),
            const SizedBox(height: 20),
            textInput(rePassword, 'Re Password', passsword: true),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                if (userName.text.isNotEmpty &&
                    email.text.isNotEmpty &&
                    password.text.isNotEmpty &&
                    rePassword.text.isNotEmpty &&
                    location != locationData[0] &&
                    experience.text.isNotEmpty &&
                    certificate.text.isNotEmpty) {
                  if (password.text == rePassword.text &&
                      password.text.length > 7) {
// Create Account Company
                    final dio = Dio();

                    var fromData = FormData.fromMap({
                      'name': userName.text.trim(),
                      'email': email.text.trim(),
                      'password': password.text,
                      'gender': gender == 'Male' ? 1 : 2,
                      'certificate': certificate.text.trim(),
                      'experience': experience.text.trim(),
                      'dataOld': dateTime,
                      'location': location,
                    });

                    Response response = await dio
                        .post(PATHS.authSignUpCustomers, data: fromData);
                    Map data = jsonDecode(response.data);
                    print(data);

                    if (data['status'] != 'fail') {
                      //  ['typeAuht']
                      await GetStorage().write('auth', {
                        'name': userName.text.trim(),
                        'email': email.text.trim(),
                        'gender': gender == 'Male' ? 1 : 2,
                        'certificate': certificate.text.trim(),
                        'experience': experience.text.trim(),
                        'dataOld': dateTime.toString(),
                        'location': location,
                        'typeAuht': 'customers',
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
                  backgroundColor: const Color(0xffff6363)),
              child: const Text(
                'انشاء الحساب',
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
