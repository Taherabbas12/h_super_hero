import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h_super_hero/colors_app.dart';

Widget textInput(controller, hint, {bool passsword = false}) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xfff0f0f0),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 103, 103, 103),
                blurRadius: 4,
                offset: Offset(2, 2))
          ]),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 18),
        obscureText: passsword,
        decoration: InputDecoration(
            labelStyle: const TextStyle(fontSize: 18),
            hintText: hint,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
Widget textInput2(controller, hint, {bool passsword = false}) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: inputColor,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 103, 103, 103),
                blurRadius: 4,
                offset: Offset(2, 2))
          ]),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 20, color: Colors.white),
        obscureText: passsword,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 217, 217, 217)),
            hintText: hint,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );

Widget textInput3N(
  controller,
  hint, {
  bool passsword = false,
}) =>
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: inputColor,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 103, 103, 103),
                blurRadius: 4,
                offset: Offset(2, 2))
          ]),
      child: TextField(
        textDirection: TextDirection.rtl,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 20, color: Colors.white),
        obscureText: passsword,
        decoration: InputDecoration(
            hintTextDirection: TextDirection.rtl,
            hintStyle: const TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 217, 217, 217)),
            hintText: hint,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );

Widget textInput3(
  controller,
  hint, {
  bool passsword = false,
}) =>
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: inputColor,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 103, 103, 103),
                blurRadius: 4,
                offset: Offset(2, 2))
          ]),
      child: TextField(
        textDirection: TextDirection.rtl,
        controller: controller,
        style: const TextStyle(fontSize: 20, color: Colors.white),
        obscureText: passsword,
        decoration: InputDecoration(
            hintStyle: const TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 217, 217, 217)),
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );

Widget textInput3Nu(
  controller,
  hint,
  context, {
  bool passsword = false,
}) =>
    Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      height: 60,
      width: MediaQuery.sizeOf(context).width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        textDirection: TextDirection.rtl,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        controller: controller,
        style: const TextStyle(fontSize: 20, color: Colors.white),
        obscureText: passsword,
        decoration: InputDecoration(
          hintTextDirection: TextDirection.rtl,
          hintStyle: const TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 217, 217, 217)),
          hintText: hint,
        ),
      ),
    );
