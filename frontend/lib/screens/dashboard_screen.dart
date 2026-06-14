import 'package:flutter/material.dart';
import 'dart:io';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  State<DashboardScreen> createState() => _DashboardScreenState();
}

class ShortcutCard extends 

class SideBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool expanded;
  final VoidCallback onTap;

  const SideBarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),

        child: Row(
          children: [
            Icon(icon),

            Expanded(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 150),
                opacity: expanded ? 1 : 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(label, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isSideBarExpanded = false;
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
      body: Row(
        children: [
          MouseRegion(
            onEnter: (_) {
              setState(() {
                isSideBarExpanded = true;
              });
            },

            onExit: (_) {
              setState(() {
                isSideBarExpanded = false;
              });
            },

            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),

              width: isSideBarExpanded ? 220 : 70,

              color: Colors.black12,

              child: Column(
                children: [
                  const SizedBox(height: 20),

                  SideBarItem(
                    icon: Icons.home_filled,
                    label: "dashboard",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),

                  SideBarItem(
                    icon: Icons.people_outline_outlined,
                    label: "Customers",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),

                  SideBarItem(
                    icon: Icons.shopping_bag,
                    label: "Orders",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),

                  SideBarItem(
                    icon: Icons.straighten,
                    label: "Measurements",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),

                  SideBarItem(
                    icon: Icons.pie_chart,
                    label: "Reports",
                    expanded: isSideBarExpanded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: Center(
              child: SizedBox(
                width: 1200,
                  child: Card(
                    elevation: 8,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),

                      child: TextField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.search),
                          hintText: "Search customers, orders, measurements...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
