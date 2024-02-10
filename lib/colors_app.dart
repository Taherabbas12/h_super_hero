import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

Color get primaryColorCo {
  try {
    return GetStorage().read('color') == "customers"
        ? const Color(0xff00637e)
        : const Color.fromARGB(255, 112, 43, 43);
  } catch (e) {
    return const Color(0xff00637e);
  }
}

Color textColor = Colors.white;

// Color get textColor {
//   try {
//     return GetStorage().read('color') == "customers"
//         ? Colors.white
//         : Color.fromARGB(255, 255, 255, 255);
//   } catch (e) {
//     return Colors.white;
//   }
// }

Color get inputColor {
  try {
    return GetStorage().read('color') == "customers"
        ? const Color(0xff00637e)
        : const Color.fromARGB(255, 112, 43, 43);
  } catch (e) {
    return const Color(0xff00637e);
  }
}
