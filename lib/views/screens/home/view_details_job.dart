// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:h_super_hero/colors_app.dart';
import 'package:h_super_hero/paths.dart';

class ViewDetailsJob extends StatelessWidget {
  ViewDetailsJob({super.key, required this.dataJob, this.expier = false});
  Map dataJob;
  bool expier;

  @override
  Widget build(BuildContext context) {
    FormData data = FormData();
    data.fields.add(MapEntry('id', dataJob['company_id']));
    print(dataJob);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: inputColor,
        foregroundColor: Colors.white,
        title: Text(
          dataJob['title_Jop'],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: Dio().post(PATHS.companyById, data: data),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data!.data);
                Map d = jsonDecode(snapshot.data!.data);
                print(d);
                return Column(
                  children: [
                    // view All details Job

                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          color: inputColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(children: [
                        viewIValueInDetails2('Name Comapny :', context,
                            value: d['data'][0]['name']),
                        viewIValueInDetails('Details this job'),
                        viewIValueInDetails('Number people :',
                            value: dataJob['number_people']),
                        viewIValueInDetails('From Age :',
                            value: dataJob['fromAge']),
                        viewIValueInDetails('To Age :',
                            value: dataJob['toAge']),
                        viewIValueInDetails('DateTime :',
                            value: dataJob['DateTime']),
                        viewIValueInDetails('Day expired :',
                            value: dataJob['dayExpired']),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: const Divider()),
                        viewIValueInDetails2('Description :', context,
                            value: dataJob['description']),
                        SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child: const Divider()),
                        viewIValueInDetails2('Responsibilities :', context,
                            value: dataJob['Responsibilities']),
                        const SizedBox(height: 50),
                      ]),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      floatingActionButton: GetStorage().read('auth')['typeAuht'] == 'Company'
          ? dataJob['company_id'] == GetStorage().read('auth')['id']
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    'Delete this job',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  onPressed: () {
                    // delete this job
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              backgroundColor: inputColor,
                              title: const Text(
                                'Are you sure you want to delete this job?',
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
                                      FormData f = FormData();
                                      f.fields
                                          .add(MapEntry('id', dataJob['id']));
                                      Response response = await Dio()
                                          .post(PATHS.deleteJob, data: f);
                                      print(response);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes')),
                              ],
                            ));
                  },
                )
              : null
          : expier
              ? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: inputColor,
                      elevation: 4,
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    'Apply for the job',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  onPressed: () {
                    //  Apply for the job
                    showDialog(
                        context: context,
                        builder: (context2) => AlertDialog(
                              backgroundColor: inputColor,
                              title: const Text(
                                  'Are you sure you want apply for this job?',
                                  style: TextStyle(color: Colors.white)),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context2);
                                    },
                                    child: const Text('No')),
                                ElevatedButton(
                                    onPressed: () async {
                                      // print(GetStorage().read('auth'));
                                      FormData f = FormData();
                                      // idCompany= ? , id_required_jobs=? , id_customers=?
                                      f.fields.add(MapEntry(
                                          'idCompany', dataJob['company_id']));
                                      f.fields.add(MapEntry(
                                          'id_required_jobs', dataJob['id']));
                                      f.fields.add(MapEntry('id_customers',
                                          GetStorage().read('auth')['id']));
                                      Response response = await Dio()
                                          .post(PATHS.addApplyJob, data: f);
                                      print(response);
                                      Map d = jsonDecode(response.data);

                                      if (d['status'] == 'success') {
                                        Navigator.pop(context2);
                                        ScaffoldMessenger.of(context2)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text(
                                                    'Success add apply  this job')));
                                        await Future.delayed(
                                            const Duration(seconds: 2));
                                        Navigator.pop(context);
                                      } else {
                                        ScaffoldMessenger.of(context2)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    'Not success add apply  this job')));
                                      }

                                      // Navigator.pop(context);
                                      // Navigator.pop(context);
                                    },
                                    child: const Text('Yes')),
                              ],
                            ));
                  },
                )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Container viewIValueInDetails(String name, {String value = ''}) {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(
                  fontSize: value.isEmpty ? 25 : 20,
                  color: Colors.white,
                  fontWeight:
                      value.isEmpty ? FontWeight.bold : FontWeight.w400),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ));
  }

  Container viewIValueInDetails2(String name, BuildContext context,
      {String value = ''}) {
    return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        width: MediaQuery.sizeOf(context).width * 0.99,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ));
  }
}
