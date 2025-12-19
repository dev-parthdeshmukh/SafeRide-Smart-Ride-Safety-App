import 'package:flutter/material.dart';
import '../models/driver_model.dart';
import 'driver_result_page.dart';
import '../widgets/animated_background.dart';

class DriverCheckPage extends StatefulWidget {
  const DriverCheckPage({super.key});

  @override
  State<DriverCheckPage> createState() => _DriverCheckPageState();
}

class _DriverCheckPageState extends State<DriverCheckPage> {
  final licenseController = TextEditingController();

  final List<Driver> demoDrivers = [
    Driver(name: "Rajesh Kumar", license: "MH12AB1234", rating: 4.2, riskLevel: "Low", reviews: 58),
    Driver(name: "Rohan Patil", license: "MH14XZ5432", rating: 3.6, riskLevel: "Medium", reviews: 31),
    Driver(name: "Deepak Yadav", license: "MH01CD8907", rating: 2.8, riskLevel: "High", reviews: 12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Hero(
                    tag: 'logo',
                    child: Icon(Icons.search_rounded,
                        size: 100, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text("Check Driver Safety",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 25),
                  _inputField(licenseController,
                      "Enter Driver License / Cab Number"),
                  const SizedBox(height: 25),
                  _animatedButton(context, "Analyze Driver"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: const Icon(Icons.badge_outlined, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _animatedButton(BuildContext context, String text) {
    return GestureDetector(
      onTap: () {
        String license = licenseController.text.trim().toUpperCase();
        Driver found = demoDrivers.firstWhere(
          (d) => d.license.toUpperCase() == license,
          orElse: () => Driver(name: "Driver Not Found", license: "-", rating: 0, riskLevel: "Unknown", reviews: 0),
        );

        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (_, __, ___) => DriverResultPage(driver: found),
            transitionsBuilder: (_, a, __, c) => SlideTransition(
              position: Tween(begin: const Offset(0, 1), end: Offset.zero)
                  .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
              child: c,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 55,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ],
        ),
        child: Text(text,
            style: const TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ),
    );
  }
}
