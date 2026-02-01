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
      lowerBound: 0.8,
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
              // TODO: Stop SOS backend call
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
                size: 80,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Alert Sent to 5 Contacts",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: _cancelAlert,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white70),
                  ),
                  child: const Text(
                    "Cancel Alert",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
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
