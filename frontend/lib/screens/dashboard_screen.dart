import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TailorOS")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {}, 
              child: const Text("customers")
              ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {}, 
              child: const Text("orders")
              ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {}, 
              child: const Text("measurments")
              ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {}, 
              child: const Text("reports")
              ),
          ],
        ),
      ),
    );
  }
}
