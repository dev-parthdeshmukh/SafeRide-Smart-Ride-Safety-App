import 'package:flutter/material.dart';
import 'dart:async';
import 'active_alert_page.dart';

class ActiveRideSOSPage extends StatefulWidget {
  const ActiveRideSOSPage({super.key});

  @override
  State<ActiveRideSOSPage> createState() => _ActiveRideSOSPageState();
}

class _ActiveRideSOSPageState extends State<ActiveRideSOSPage> {
  Timer? _timer;
  double _progress = 0;

  void _startHold() {
    _progress = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      setState(() => _progress += 0.033);
      if (_progress >= 1) {
        t.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const ActiveAlertPage()),
        );
      }
    });
  }

  void _cancelHold() {
    _timer?.cancel();
    setState(() => _progress = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 30),

            // Title
            const Text(
              "Emergency SOS",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            // SOS Button
            GestureDetector(
              onLongPressStart: (_) => _startHold(),
              onLongPressEnd: (_) => _cancelHold(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 6,
                      backgroundColor: Colors.white24,
                      valueColor:
                          const AlwaysStoppedAnimation(Colors.redAccent),
                    ),
                  ),
                  Container(
                    width: 170,
                    height: 170,
                    decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_active,
                            color: Colors.white, size: 36),
                        SizedBox(height: 6),
                        Text(
                          "SOS",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Text(
              "Press & hold for 3 seconds\nSends SMS & Location",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),

            // End Ride Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text("Arrived Safely?"),
                        content: const Text(
                          "Are you sure you have arrived safely?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Navigate to feedback page
                            },
                            child: const Text("Confirm"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "End Ride / Arrived Safely",
                    style: TextStyle(
                      color: Colors.indigo,
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
