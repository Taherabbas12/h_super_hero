// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:h_super_hero/colors_app.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  ProfileData2? profileDataView2;
  ProfileData? profileDataView;
  DateTime? dateTime;
  @override
  Widget build(BuildContext context) {
    if (GetStorage().read('color') == "customers") {
      profileDataView = ProfileData.fromMap(GetStorage().read('auth'));
      dateTime = DateTime.parse(profileDataView!.dataOld);
    } else {
      profileDataView2 = ProfileData2.fromMap(GetStorage().read('auth'));
    }
    return SingleChildScrollView(
      child: GetStorage().read('color') == "customers"
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                    child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(profileDataView!.gender == 1
                                    ? 'assets/male.png'
                                    : 'assets/female.png'))))),
                viewValue('Name', profileDataView!.name),
                viewValue('Email', profileDataView!.email),
                viewValue('Location', profileDataView!.location),
                viewValue(
                    'Gender', profileDataView!.gender == 1 ? "male" : "female"),
                viewValue('Date ',
                    '${dateTime!.year}/${dateTime!.month}/${dateTime!.day}'),
                viewValue('Experience', profileDataView!.experience),
                viewValue('Certificate', profileDataView!.certificate),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(0, 50),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.red,
                          title: const Text(
                            'Are You Already Sign out',
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                            ElevatedButton(
                                onPressed: () async {
                                  await GetStorage().remove('auth');
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      'SplashScreen', (route) => false);
                                },
                                child: const Text('Sign Out')),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                    child: Container(
                        width: 250,
                        height: 250,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/female.png'))))),
                viewValue('Name', profileDataView2!.name),
                viewValue('Email', profileDataView2!.email),
                viewValue('Location', profileDataView2!.location),
                viewValue('Describtion', profileDataView2!.describtion),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(0, 50),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.red,
                          title: const Text(
                            'Are You Already Sign out',
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                            ElevatedButton(
                                onPressed: () async {
                                  GetStorage().remove('color');
                                  await GetStorage().remove('auth');
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                child: const Text('Sign Out')),
                          ],
                        ),
                      );
                    },
                    child: const Text(
                      'Sign Out',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
    );
  }

  Widget viewValue(name, value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: primaryColorCo, borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      child: Text(
        '$name : $value',
        style: TextStyle(fontSize: 20, color: textColor),
      ),
    );
  }
}

class ProfileData {
  String name, email, certificate, experience, dataOld, location, typeAuht;
  int gender;

  ProfileData({
    required this.name,
    required this.certificate,
    required this.dataOld,
    required this.email,
    required this.experience,
    required this.gender,
    required this.location,
    required this.typeAuht,
  });

  factory ProfileData.fromMap(Map data) {
    return ProfileData(
      name: data['name'] ?? '',
      certificate: data['certificate'] ?? '',
      dataOld: data['dataOld'] ?? '',
      email: data['email'] ?? '',
      experience: data['experience'] ?? '',
      gender: int.parse(data['gender'].toString()),
      location: data['location'] ?? '',
      typeAuht: data['typeAuht'] ?? '',
    );
  }
}

class ProfileData2 {
  String name, email, describtion, location, typeAuht;

  ProfileData2({
    required this.name,
    required this.email,
    required this.location,
    required this.typeAuht,
    required this.describtion,
  });

  factory ProfileData2.fromMap(Map data) {
    return ProfileData2(
      name: data['name'] ?? '',
      describtion: data['describtion'] ?? '',
      email: data['email'] ?? '',
      location: data['location'] ?? '',
      typeAuht: data['typeAuht'] ?? '',
    );
  }
}
