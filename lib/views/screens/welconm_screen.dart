import 'package:flutter/material.dart';
import 'package:h_super_hero/colors_app.dart';

class WelcoomeScreen extends StatelessWidget {
  const WelcoomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Hello Job Seeker Application',
            style: TextStyle(fontSize: 35),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 45),
                      backgroundColor: primaryColorCo),
                  onPressed: () {
                    //
                    Navigator.pushNamed(context, 'AuthType');
                  },
                  child: const Text(
                    'Start',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )))
        ],
      ),
    );
  }
}
