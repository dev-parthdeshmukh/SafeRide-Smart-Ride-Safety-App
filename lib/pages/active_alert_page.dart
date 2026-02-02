import 'package:flutter/material.dart';

class ActiveAlertPage extends StatefulWidget {
  const ActiveAlertPage({super.key});

  @override
  State<ActiveAlertPage> createState() => _ActiveAlertPageState();
}

class _ActiveAlertPageState extends State<ActiveAlertPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulse;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  void _cancelAlert() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Enter Safety PIN"),
        content: TextField(
          keyboardType: TextInputType.number,
          maxLength: 4,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: "4-digit PIN",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _pulse,
              child: const Icon(
                Icons.wifi_tethering,
                color: Colors.redAccent,
                size: 70,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Alert Sent to 5 Contacts",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: _cancelAlert,
                child: Container(
                  height: 55,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white, // 👈 solid white
                    borderRadius: BorderRadius.circular(32), // 👈 pill shape
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26, // 👈 soft shadow
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Cancel Alert",
                    style: TextStyle(
                      color: Colors.indigo, // 👈 same text color
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
