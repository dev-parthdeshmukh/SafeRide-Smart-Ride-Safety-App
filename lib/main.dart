import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Your pages
import 'pages/splash_screen.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/emergency_details_page.dart';
import 'pages/driver_check_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const SafeRideApp());
}

class SafeRideApp extends StatelessWidget {
  const SafeRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeRide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.black,
      ),
      //  Start with splash screen
      home: const SplashScreen(),

      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/emergency': (context) => const EmergencyDetailsPage(),
        '/driverCheck': (context) => const DriverCheckPage(),
      },
    );
  }
}
