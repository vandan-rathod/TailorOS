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
          children: [
            Container(
              height: 55,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade100),
                borderRadius: BorderRadius.circular(27.5),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: TextButton(
                      onPressed: () {}, 
                      child: const Text("Customers")
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: TextButton(
                    onPressed: () {}, 
                    child: const Text("DashBoard")
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: TextButton(
                      onPressed: () {}, 
                      child: const Text("Orders")
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: TextButton(
                      onPressed: () {}, 
                      child: const Text("Measurments")
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: TextButton(
                      onPressed: () {}, 
                      child: const Text("Reports")
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
