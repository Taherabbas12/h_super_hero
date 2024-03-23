import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../paths.dart';

class LogicJobs {
  static Future<bool> editMessageJob(
      String id, String message, BuildContext context) async {
//

    FormData formData = FormData();
    formData.fields.add(MapEntry('id', id));
    formData.fields.add(MapEntry('message', message));
    Response response = await Dio().post(PATHS.editMessageJob, data: formData);
    print(response);
    Map d = jsonDecode(response.data);
    print('______________AAA123');
    print(d);
    print('______________AAA123');
    //
    if (d['status'] == 'success') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Reply added')));
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Adding reply failed'),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }

  static Future<bool> addJob(
      AddJob dataAddJob, context, String nameTypeJobs) async {
    print(await GetStorage().read('auth')['id']);
    if (dataAddJob.titleJob.isNotEmpty &&
        dataAddJob.numberRequierd.isNotEmpty &&
        dataAddJob.oldTo.isNotEmpty &&
        dataAddJob.oldFrom.isNotEmpty &&
        dataAddJob.descripeJob.isNotEmpty &&
        dataAddJob.deutyJob.isNotEmpty &&
        dataAddJob.timeAvildate.isNotEmpty &&
        dataAddJob.requiredJob.isNotEmpty) {
      var fromData = FormData.fromMap({
        "company_id": await GetStorage().read('auth')['id'],
        "title_Jop": dataAddJob.titleJob,
        "number_people": dataAddJob.numberRequierd,
        "toAge": dataAddJob.oldTo,
        "type_jop": nameTypeJobs,
        "description": dataAddJob.descripeJob,
        "DateTime": DateTime.now(),
        "dayExpired": dataAddJob.timeAvildate,
        "Expired": '0',
        "Responsibilities": dataAddJob.deutyJob,
        "Requirements": dataAddJob.requiredJob,
        "fromAge": dataAddJob.oldFrom
      });

      Response data = await Dio().post(PATHS.addJob, data: fromData);
      print(data);
      Map dataMap = jsonDecode(data.data);
      if (dataMap["status"] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Accept added job'),
          backgroundColor: Colors.green,
        ));
        return true;
      }
    } else {
      // is any value is empty
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('يرجى ملأ كل الحقول'),
        backgroundColor: Colors.red,
      ));
      return false;
    }
    return false;
  }
}

class AddJob {
  String titleJob;
  String numberRequierd;
  String oldTo;
  String oldFrom;
  String descripeJob;
  String timeAvildate;
  String deutyJob;
  String requiredJob;
  AddJob({
    required this.descripeJob,
    required this.deutyJob,
    required this.numberRequierd,
    required this.oldFrom,
    required this.oldTo,
    required this.requiredJob,
    required this.timeAvildate,
    required this.titleJob,
  });
}
