import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/driver_model.dart';
import '../widgets/animated_background.dart';

class DriverResultPage extends StatefulWidget {
  final Driver driver;
  const DriverResultPage({super.key, required this.driver});

  @override
  State<DriverResultPage> createState() => _DriverResultPageState();
}

class _DriverResultPageState extends State<DriverResultPage>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _gaugeController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _gaugeAnimation;

  Color _riskColor(String riskLevel) {
    switch (riskLevel) {
      case "Low":
        return Colors.greenAccent.shade400;
      case "Medium":
        return Colors.orangeAccent.shade200;
      case "High":
        return Colors.redAccent.shade200;
      default:
        return Colors.grey.shade400;
    }
  }

  double _riskPercent(String riskLevel) {
    switch (riskLevel) {
      case "Low":
        return 0.85;
      case "Medium":
        return 0.60;
      case "High":
        return 0.35;
      default:
        return 0.0;
    }
  }

  String _recommendation(String riskLevel) {
    switch (riskLevel) {
      case "Low":
        return "✅ This driver is safe. You can ride comfortably.";
      case "Medium":
        return "⚠️ This driver has mixed reviews. Stay alert during the ride.";
      case "High":
        return "🚫 This driver is unsafe. We recommend avoiding this ride.";
      default:
        return "Driver not found in our database.";
    }
  }

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _gaugeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation =
        CurvedAnimation(parent: _slideController, curve: Curves.easeIn);

    _gaugeAnimation = Tween<double>(
      begin: 0,
      end: _riskPercent(widget.driver.riskLevel),
    ).animate(CurvedAnimation(
      parent: _gaugeController,
      curve: Curves.easeOutCubic,
    ));

    // Run both animations
    _gaugeController.forward();
    Future.delayed(const Duration(milliseconds: 600), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _gaugeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = _riskColor(widget.driver.riskLevel);
    final recommendation = _recommendation(widget.driver.riskLevel);

    return Scaffold(
      body: AnimatedBackground(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Hero(
                  tag: 'logo',
                  child: Icon(Icons.shield, size: 90, color: Colors.white),
                ),
                const SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _gaugeController,
                  builder: (context, _) {
                    return CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 16.0,
                      percent: _gaugeAnimation.value,
                      animation: true,
                      center: Text(
                        "${(_gaugeAnimation.value * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      progressColor: color,
                      backgroundColor: Colors.white24,
                      circularStrokeCap: CircularStrokeCap.round,
                    );
                  },
                ),
                const SizedBox(height: 30),
                SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.05)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(widget.driver.name,
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text("License: ${widget.driver.license}",
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 15)),
                          const SizedBox(height: 15),
                          Text(
                            recommendation,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              minimumSize:
                                  const Size(double.infinity, 50),
                            ),
                            child: const Text("Continue Ride",
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
