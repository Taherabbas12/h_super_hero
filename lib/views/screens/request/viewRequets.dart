// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:h_super_hero/colors_app.dart';
import 'package:h_super_hero/paths.dart';
import 'package:h_super_hero/views/screens/request/view_company.dart';
import 'package:h_super_hero/views/widgets/text_input.dart';

import '../../../logic/logic_jobs.dart';
import 'view_customer.dart';

class ViewRequest extends StatefulWidget {
  ViewRequest({super.key});

  @override
  State<ViewRequest> createState() => _ViewRequestState();
}

class _ViewRequestState extends State<ViewRequest> {
  String pathViewRequest = '';

  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    pathViewRequest = '';
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
                        trailing: GetStorage().read('color') != "customers"
                            ? IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  message.text =
                                      d['data'][index]['reply_by_message'];
                                  //
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Write Reply Message'),
                                      content: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.9,
                                          child: textInputMessage(
                                              message, 'Message Reply')),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        ElevatedButton(
                                            onPressed: () async {
                                              bool isState = await LogicJobs
                                                  .editMessageJob(
                                                      d['data'][index]['id'],
                                                      message.text.trim(),
                                                      context);
                                              if (isState) {
                                                setState(() {});
                                              } else {}
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Send')),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : d['data'][index]['reply_by_message'] != ''
                                ? IconButton(
                                    icon: const Icon(
                                      Icons.notifications_on_outlined,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      //
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Message Reply'),
                                          content: Text(d['data'][index]
                                              ['reply_by_message']),
                                        ),
                                      );
                                    },
                                  )
                                : null,
                        onTap: () {
                          // {id: 6, idCompany: 4, id_required_jobs: 8,
                          // id_customers: 11, reply_by_message: alisufhasfluahs,
                          // name: huda mohamed, title_Jop: IT, nameCostumer: Huda}
                          if (GetStorage().read('color') != "customers") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewCustomer(
                                    id: d['data'][index]['id_customers'],
                                  ),
                                ));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewCompany(
                                    id: d['data'][index]['idCompany'],
                                  ),
                                ));
                          }
                          //
                          print(d['data'][index]);
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
