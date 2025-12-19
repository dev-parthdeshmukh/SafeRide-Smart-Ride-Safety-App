import 'package:flutter/material.dart';
import '../widgets/animated_background.dart';

class EmergencyDetailsPage extends StatefulWidget {
  const EmergencyDetailsPage({super.key});

  @override
  State<EmergencyDetailsPage> createState() => _EmergencyDetailsPageState();
}

class _EmergencyDetailsPageState extends State<EmergencyDetailsPage> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final relationController = TextEditingController();

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
                    child: Icon(Icons.contact_emergency,
                        size: 100, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Add Emergency Contact",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 🧍 Emergency Contact Name
                  _inputField(nameController, "Full Name", Icons.person),

                  const SizedBox(height: 16),

                  // 📞 Emergency Contact Number
                  _inputField(contactController, "Contact Number", Icons.phone),

                  const SizedBox(height: 16),

                  // 👨‍👩‍👧 Relationship
                  _inputField(relationController, "Relationship", Icons.group),

                  const SizedBox(height: 25),
                  _animatedButton(context, "Continue", '/driverCheck'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //  Reusable Input Field Widget
  Widget _inputField(TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  //  Continue Button
  Widget _animatedButton(BuildContext context, String text, String route) {
    return GestureDetector(
      onTap: () {
        if (nameController.text.isEmpty ||
            contactController.text.isEmpty ||
            relationController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please fill all details"),
              backgroundColor: Colors.redAccent,
            ),
          );
          return;
        }

        // For now just navigate (you can also save to Firebase later)
        Navigator.pushNamed(context, route);
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
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.indigo,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
