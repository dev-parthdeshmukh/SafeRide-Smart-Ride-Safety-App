import 'package:flutter/material.dart';
import 'active_alert_page.dart';
import 'dart:async';

class ActiveRideSOSPage extends StatefulWidget {
  const ActiveRideSOSPage({super.key});

  @override
  State<ActiveRideSOSPage> createState() => _ActiveRideSOSPageState();
}

class _ActiveRideSOSPageState extends State<ActiveRideSOSPage> {
  Timer? _holdTimer;
  double _progress = 0.0;

  void _startHold() {
    _progress = 0;
    _holdTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 0.033;
      });

      if (_progress >= 1) {
        timer.cancel();
        _triggerSOS();
      }
    });
  }

  void _cancelHold() {
    _holdTimer?.cancel();
    setState(() => _progress = 0);
  }

  void _triggerSOS() {
    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => const ActiveAlertPage(),
  ),
);
  }

  void _endRide() {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),

            // Header
            const Text(
              "Emergency SOS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
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
                      strokeWidth: 8,
                      backgroundColor: Colors.white24,
                      valueColor:
                          const AlwaysStoppedAnimation(Colors.redAccent),
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 180,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_active,
                            color: Colors.white, size: 40),
                        SizedBox(height: 8),
                        Text(
                          "SOS",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
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
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton(
                  onPressed: _endRide,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: const Text(
                    "End Ride / Arrived Safely",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
