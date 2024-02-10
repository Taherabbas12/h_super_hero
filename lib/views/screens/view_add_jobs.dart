// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:h_super_hero/paths.dart';

import '../../colors_app.dart';
import '../../logic/logic_jobs.dart';
import '../widgets/text_input.dart';
import 'home/view_details_job.dart';

class ViewAddJobs extends StatefulWidget {
  ViewAddJobs({super.key, required this.nameTypeJobs});
  String nameTypeJobs;

  @override
  State<ViewAddJobs> createState() => _ViewAddJobsState();
}

class _ViewAddJobsState extends State<ViewAddJobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nameTypeJobs),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Dio().post(PATHS.viewJob,
              data: FormData.fromMap({"type_jop": widget.nameTypeJobs})),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map data = jsonDecode(snapshot.data.toString());
              print(data);
              // return Text('da');
              if (data['status'] == 'success') {
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

                            setState(() {});
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
                return const Center(
                  child: Text(
                      'No complications have been added to this section',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                );
              }
            } else {
              return Center(
                child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    child: const LinearProgressIndicator()),
              );
            }
          },
        ),
      ),
      floatingActionButton: GetStorage().read('auth')['typeAuht'] == 'Company'
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Add(
                        nameTypeJobs: widget.nameTypeJobs,
                      ),
                    ));
                setState(() {});
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}

class Add extends StatelessWidget {
  Add({super.key, required this.nameTypeJobs});
  String nameTypeJobs;

  @override
  Widget build(BuildContext context) {
    TextEditingController titleJob = TextEditingController();
    TextEditingController numberRequierd = TextEditingController();
    TextEditingController oldTo = TextEditingController();
    TextEditingController oldFrom = TextEditingController();
    TextEditingController descripeJob = TextEditingController();
    TextEditingController timeAvildate = TextEditingController();
    TextEditingController deutyJob = TextEditingController();
    TextEditingController requiredJob = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add :$nameTypeJobs'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            textInput3(titleJob, 'العنوان الوظيفي'),
            const SizedBox(height: 10),
            textInput3N(numberRequierd, 'العدد المطلوب للوظيفة'),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: inputColor,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 103, 103, 103),
                          blurRadius: 4,
                          offset: Offset(2, 2))
                    ]),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  textInput3Nu(oldTo, 'الى ', context),
                  const SizedBox(width: 20),
                  textInput3Nu(oldFrom, 'من ', context),
                  const SizedBox(width: 10),
                  const Text(' : العمر',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
            ),
            const SizedBox(height: 10),
            textInput3(descripeJob, 'وصف الوظيفة'),
            const SizedBox(height: 10),
            textInput3N(timeAvildate, 'التقديم متاح لمده ... من الايام'),
            const SizedBox(height: 10),
            textInput3(deutyJob, 'واجبات المتقدم'),
            const SizedBox(height: 10),
            textInput3(requiredJob, 'متطلبات الوظيفة'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                AddJob dataAddJob = AddJob(
                    descripeJob: deutyJob.text,
                    deutyJob: deutyJob.text,
                    numberRequierd: numberRequierd.text,
                    oldFrom: oldFrom.text,
                    oldTo: oldTo.text,
                    requiredJob: requiredJob.text,
                    timeAvildate: timeAvildate.text,
                    titleJob: titleJob.text);
                bool isAdd =
                    await LogicJobs.addJob(dataAddJob, context, nameTypeJobs);
                if (isAdd) {
                  titleJob.text = '';
                  numberRequierd.text = '';
                  oldTo.text = '';
                  oldFrom.text = '';
                  descripeJob.text = '';
                  timeAvildate.text = '';
                  deutyJob.text = '';
                  requiredJob.text = '';
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Make sure you are connected to the Internet'),
                    backgroundColor: Colors.red,
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 60),
                  elevation: 10,
                  backgroundColor: inputColor),
              child: const Text('اضافة وظيفة',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }
}
