import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../colors_app.dart';
import '../../../paths.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Dio().get(PATHS.conterAllTable),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data.toString());

          return Wrap(
            children: [
              const SizedBox(
                height: 20,
                width: double.infinity,
              ),
              Center(
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: (MediaQuery.sizeOf(context).width * 0.9) * 0.8,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 181, 181, 181)),
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
                          image: AssetImage(
                              'assets/undraw_Updated_resume_re_7r9j.png'))),
                ),
              ),
              const SizedBox(
                height: 20,
                width: double.infinity,
              ),
              viewValue('Companies', data['company_count'], context),
              viewValue('Candidates', data['customers_count'], context),
              viewValue('All Job', data['required_jobs_count'], context),
              viewValue('Live Jobs', data['expired_false_count'], context),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget viewValue(name, value, context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.45,
      height: MediaQuery.sizeOf(context).width * 0.45,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(
          color: primaryColorCo, borderRadius: BorderRadius.circular(10)),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$name',
            style: TextStyle(fontSize: 25, color: textColor),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '$value',
            style: TextStyle(fontSize: 35, color: textColor),
          ),
        ],
      ),
    );
  }
//   {
//   "company_count": "3",
//   "required_jobs_count": "0",
//   "customers_count": "7"
// }
}
