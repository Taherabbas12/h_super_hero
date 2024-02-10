import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:h_super_hero/colors_app.dart';
import 'package:h_super_hero/paths.dart';

class ViewRequest extends StatelessWidget {
  ViewRequest({super.key});
  String pathViewRequest = '';
  @override
  Widget build(BuildContext context) {
    // FormData data = FormData();
    // data.fields.add(MapEntry('idCompany', ));
    FormData data = FormData();
    //  GetStorage().write('auth', {
    //                     'id': data['data'][0]['id'],

    if (GetStorage().read('color') == "customers") {
      data.fields
          .add(MapEntry('id_customers', GetStorage().read('auth')['id']));
      pathViewRequest = PATHS.viewRequestCostumer;
    } else {
      data.fields.add(MapEntry('idCompany', GetStorage().read('auth')['id']));
      pathViewRequest = PATHS.viewRequestCompany;
    }
    //chose auth

// GetStorage().read('color')
    return FutureBuilder(
      future: Dio().post(pathViewRequest, data: data),
      builder: (context, snapshot) {
        print(snapshot.data);
        if (snapshot.hasData) {
          Map d = jsonDecode(snapshot.data!.data);
          print(d);
          if (d['status'] != 'fail') {
            return ListView.builder(
                itemCount: d['data'].length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 3),

                      //      {
                      //   "id": "5",
                      //   "idCompany": "2",
                      //   "id_required_jobs": "1",
                      //   "id_customers": "4",
                      //   "name": "Huda Mohammed Salman",
                      //   "title_Jop": "Java Sineor Developer",
                      //   "nameCostumer": "huda"
                      // },
                      child: ListTile(
                        onTap: () {
                          //
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        tileColor: inputColor,
                        title: Text(
                          'Title Jop : ${d['data'][index]['title_Jop']}',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                        subtitle: Text(
                          'Company   : ${d['data'][index]['name']}\nCostumer   : ${d['data'][index]['nameCostumer']}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 224, 224, 224),
                              fontSize: 17),
                        ),
                      ),
                    ));
          } else {
            return const Center(
              child: Text(
                'No has data',
                style: TextStyle(fontSize: 25),
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
