import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../colors_app.dart';
import '../../../paths.dart';
import 'view_details_job.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
            print(d.length);

            return ListView.builder(
                itemCount: data['data'].length,
                itemBuilder: (context, index) {
                  Duration difference = DateTime.now().difference(
                      DateTime.parse(data['data'][index]['DateTime']));

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
                                dataJob: data['data'][index],
                                expier: difference.inDays <=
                                    int.parse(
                                        data['data'][index]['dayExpired']),
                              ),
                            ));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      tileColor: inputColor,
                      title: Text(
                        data['data'][index]['title_Jop'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        'available : ${difference.inDays <= int.parse(data['data'][index]['dayExpired']) ? data['data'][index]['dayExpired'] : 'Expired'} day',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 207, 207, 207)),
                      ),
                      trailing: Text(
                        data['data'][index]['DateTime'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                });
          } else {
            return const Text('No jobs have been added yet');
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  // Widget viewValue(name, value, context) {
  //   return Container(
  //     width: MediaQuery.sizeOf(context).width * 0.45,
  //     height: MediaQuery.sizeOf(context).width * 0.45,
  //     margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  //     decoration: BoxDecoration(
  //         color: primaryColorCo, borderRadius: BorderRadius.circular(10)),
  //     alignment: Alignment.center,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           '$name',
  //           style: TextStyle(fontSize: 25, color: textColor),
  //         ),
  //         const SizedBox(
  //           height: 15,
  //         ),
  //         Text(
  //           '$value',
  //           style: TextStyle(fontSize: 35, color: textColor),
  //         ),
  //       ],
  //     ),
  //   );
  // }
//   {
//   "company_count": "3",
//   "required_jobs_count": "0",
//   "customers_count": "7"
// }
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
