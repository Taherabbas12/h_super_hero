// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../paths.dart';
import '../home/profile.dart';

class ViewCompany extends StatelessWidget {
  ViewCompany({super.key, required this.id});
  String id;
  FormData? formData;

  @override
  Widget build(BuildContext context) {
    formData = FormData();

    formData!.fields.add(MapEntry('id', id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Company'),
      ),
      body: FutureBuilder(
        future: Dio().post(PATHS.viewCompany, data: formData),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // {"status":"success","data":[{"id":"4","name":"huda mohamed",
            //"gmail":"huda111@gmail.com","location":"Sulaymaniyah",
            //"describtion":"The co \n\n"}]}
            print("____________________");

            print(snapshot.data);
            print("____________________");
            Map d = jsonDecode(snapshot.data!.data);
            d = d['data'][0];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                viewValue('Name', d['name']),
                viewValue('Email', d['gmail']),
                viewValue('Location', d['location']),
                viewValue('Experience', d['describtion']),
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
