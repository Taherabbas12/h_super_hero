import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'views/screens/auth/auth_type.dart';
import 'views/screens/auth/sign_in.dart';
import 'views/screens/auth/sign_in_costomer.dart';
import 'views/screens/auth/sign_screen.dart';
import 'views/screens/auth/sign_screen_customers.dart';
import 'views/screens/auth/sign_up.dart';
import 'views/screens/auth/sign_up_customers.dart';
import 'views/screens/home/home_screen.dart';
import 'views/screens/splash_screen.dart';

void main() async {
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String dataType = '';
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    try {
      print('______AAA');
      dataType = box.read('auth')['typeAuht'];

      print('$dataType');
    } catch (e) {}
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => dataType.isEmpty ? AuthType() : const HomeScreen(),
        // 'SplashScreen': (context) => SplashScreen(),
        'SignScreenCompany': (context) => const SignScreenCompany(),
        'SignScreenCustomers': (context) => const SignScreenCustomers(),
        'SignIn': (context) => SignIn(),
        'SignUp': (context) => SignUp(),
        'SignInCustomers': (context) => SignInCustomers(),
        'SignUpCustomers': (context) => SignUpCustomers(),
        'AuthType': (context) => const AuthType(),
        'HomeScreen': (context) => const HomeScreen(),
      },
    );
  }
}
