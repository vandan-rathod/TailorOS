import 'package:flutter/material.dart';
import 'dart:io';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TailorOS"),

        actions: [
          const Center(child: Text("ANIL")),

          const SizedBox(width: 15),

          TextButton(
            onPressed: () {
              exit(0);
            },
            child: const Text("Logout"),
          ),

          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            ElevatedButton(onPressed: () {}, child: const Text("customers")),

            const SizedBox(height: 10),

            ElevatedButton(onPressed: () {}, child: const Text("orders")),

            const SizedBox(height: 10),

            ElevatedButton(onPressed: () {}, child: const Text("measurments")),

            const SizedBox(height: 10),

            ElevatedButton(onPressed: () {}, child: const Text("reports")),
          ],
        ),
      ),
    );
  }
}
