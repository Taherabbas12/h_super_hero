// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../paths.dart';
import '../home/profile.dart';

class ViewCustomer extends StatelessWidget {
  ViewCustomer({super.key, required this.id});
  String id;
  FormData? formData;

  @override
  Widget build(BuildContext context) {
    formData = FormData();

    formData!.fields.add(MapEntry('id', id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Costumer'),
      ),
      body: FutureBuilder(
        future: Dio().post(PATHS.viewCustomers, data: formData),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // {"status":"success","data":[{"id":"11","name":"Huda","gmail":"huda@gmail.com",
            //"gender":"2","certificate":"Java","experience":"Java Experience","dataOld":"22",
            //"location":"Babil"}]}
            print("____________________");

            print(snapshot.data);
            print("____________________");
            Map d = jsonDecode(snapshot.data!.data);
            d = d['data'][0];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                    child: Container(
                        width: 250,
                        height: 250,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    int.parse(d['gender'].toString()) == 1
                                        ? 'assets/male.png'
                                        : 'assets/female.png'))))),
                viewValue('Name', d['name']),
                viewValue('Email', d['gmail']),
                viewValue('Location', d['location']),
                viewValue('Gender',
                    int.parse(d['gender'].toString()) == 1 ? "male" : "female"),
                viewValue('Old ', d['dataOld']),
                viewValue('Experience', d['experience']),
                viewValue('Certificate', d['certificate']),
                const SizedBox(
                  height: 30,
                )
              ],
            );
          }
          return Center(
            child: SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.7,
                child: const LinearProgressIndicator()),
          );
        },
      ),
    );
  }
}
