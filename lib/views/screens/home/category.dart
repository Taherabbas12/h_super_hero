import 'package:flutter/material.dart';

import '../../../colors_app.dart';
import '../view_add_jobs.dart';

class CategoryMolde {
  String name, value;
  CategoryMolde(this.name, this.value);
}

class Category extends StatelessWidget {
  Category({super.key});

  List<CategoryMolde> categorys = [
    CategoryMolde("Front-end developer", ''),
    CategoryMolde("Design/Creative", ''),
    CategoryMolde("Back-end developer", ''),
    CategoryMolde("Mobile Apps development", ''),
    CategoryMolde("IT & Telecommunication", ''),
    CategoryMolde("Software Development", ''),
    CategoryMolde("Programing", ''),
    CategoryMolde("Others", ''),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
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
              for (CategoryMolde i in categorys)
                viewValue(i.name, i.value, context),
            ],
          ),
        ));
  }

  Widget viewValue(String name, String value, context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewAddJobs(nameTypeJobs: name),
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
            color: primaryColorCo, borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 25, color: textColor),
              textAlign: TextAlign.start,
            ),
            Text(
              value,
              style: TextStyle(fontSize: 25, color: textColor),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}
