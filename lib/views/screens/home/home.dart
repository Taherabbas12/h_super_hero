import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../colors_app.dart';
import '../../../paths.dart';
import 'view_details_job.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Dio().get(PATHS.viewAllJob),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data!.data);

          if (data['status'] == 'success') {
            //
            List d = data['data'];
            //  search

            d = d
                .where(
                  (element) => element['title_Jop']
                      .toString()
                      .toLowerCase()
                      .contains(search.text.toLowerCase().trim()),
                )
                .toList();
            return Column(
              children: [
                SizedBox(
                    height: 60,
                    child: CupertinoSearchTextField(
                      controller: search,
                      onChanged: (v) {
                        setState(() {});
                      },
                      backgroundColor: primaryColorCo.withOpacity(0.8),
                      itemColor: Colors.white,
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                    )),
                Expanded(
                  child: ListView.builder(
                      itemCount: d.length,
                      itemBuilder: (context, index) {
                        Duration difference = DateTime.now()
                            .difference(DateTime.parse(d[index]['DateTime']));

                        // عرض الفارق
                        print('الفارق الكلي: ${difference.toString()}');
                        print('الأيام: ${difference.inDays}');
                        // print('الساعات: ${difference.inHours}');
                        // print('الدقائق: ${difference.inMinutes}');
                        // print('الثواني: ${difference.inSeconds}');
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ListTile(
                            onTap: () async {
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ViewDetailsJob(
                                      dataJob: d[index],
                                      expier: difference.inDays <=
                                          int.parse(d[index]['dayExpired']),
                                    ),
                                  ));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            tileColor: inputColor,
                            title: Text(
                              d[index]['title_Jop'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'available : ${difference.inDays <= int.parse(d[index]['dayExpired']) ? data['data'][index]['dayExpired'] : 'Expired'} day',
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 207, 207, 207)),
                            ),
                            trailing: Text(
                              d[index]['DateTime'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          } else {
            return const Text('No jobs have been added yet');
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// return Wrap(
//   children: [
//     const SizedBox(
//       height: 20,
//       width: double.infinity,
//     ),
//     Center(
//       child: Container(
//         width: MediaQuery.sizeOf(context).width * 0.9,
//         height: (MediaQuery.sizeOf(context).width * 0.9) * 0.8,
//         decoration: BoxDecoration(
//             border: Border.all(
//                 color: const Color.fromARGB(255, 181, 181, 181)),
//             borderRadius: BorderRadius.circular(15),
//             boxShadow: const [
//               BoxShadow(
//                   blurRadius: 5,
//                   spreadRadius: 0.1,
//                   color: Color.fromARGB(255, 177, 177, 177),
//                   offset: Offset(2, 2))
//             ],
//             image: const DecorationImage(
//                 fit: BoxFit.cover,
//                 image: AssetImage(
//                     'assets/undraw_Updated_resume_re_7r9j.png'))),
//       ),
//     ),
//     const SizedBox(
//       height: 20,
//       width: double.infinity,
//     ),
//     viewValue('Companies', data['company_count'], context),
//     viewValue('Candidates', data['customers_count'], context),
//     viewValue('All Job', data['required_jobs_count'], context),
//     viewValue('Live Jobs', data['expired_false_count'], context),
//   ],
// );
