import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AuthType extends StatelessWidget {
  const AuthType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 100,
          ),
          Image.asset('assets/sign.png'),
          const SizedBox(
            height: 150,
          ),
          ElevatedButton(
            onPressed: () async {
              await GetStorage().write('color', 'Company');
              Navigator.pushNamed(context, 'SignScreenCompany');
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 60),
                elevation: 10,
                backgroundColor: Colors.redAccent),
            child: const Text(
              'شركة او مؤسسة',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              GetStorage().write('color', 'customers');

              Navigator.pushNamed(context, 'SignScreenCustomers');
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 60),
                elevation: 10,
                backgroundColor: const Color.fromARGB(255, 159, 159, 159)),
            child: const Text(
              'عميل عادي',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ]),
      ),
    );
  }
}
